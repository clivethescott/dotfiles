local M = {}

local codelens = function(bufnr, au_group)
  vim.keymap.set('n', '<space>ll',
    function() vim.lsp.codelens.run() end, { buffer = true, desc = 'Run Codelens' })

  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter' }, {
    group = au_group,
    buffer = bufnr,
    desc = 'Refresh code lens for supported languages',
    callback = function()
      vim.lsp.codelens.refresh()
    end
  })
end

local formatting = function(bufnr)
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require'utils'.lsp_buf_format(bufnr)
  end, { buffer = true, desc = 'LSP Format' })
end

local diagnostics = function(bufnr)
  vim.keymap.set('n', '<space>ld',
    function() vim.diagnostic.setqflist() end,
    { desc = 'LSP Diagnostic', buffer = bufnr })

  vim.keymap.set('n', '<leader>d',
    function() vim.diagnostic.open_float({ scope = 'line' }) end,
    { desc = 'Line Diagnostic', buffer = bufnr })

  vim.keymap.set('n', '[e',
    function()
      vim.diagnostic.goto_prev {
        wrap = false,
        severity = { min = vim.diagnostic.severity.WARN }
      }
    end, { desc = 'Prev Warning or Error', buffer = bufnr })

  vim.keymap.set('n', ']e',
    function()
      vim.diagnostic.goto_next {
        wrap = true,
        severity = { min = vim.diagnostic.severity.WARN }
      }
    end,
    { desc = 'Next Warning or Error', buffer = bufnr })
end

function M.on_attach(client, bufnr)
  local lsp_group = vim.api.nvim_create_augroup('LspAttachedGroup', { clear = true })

  if client.name == 'copilot' then return end

  if client.supports_method('textDocument/rename') then
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
  end

  if client.supports_method('textDocument/codeAction') then
    vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, { buffer = true, desc = 'LSP Code Action' })
  end

  if client.supports_method('textDocument/declaration') then
    vim.keymap.set('n', 'gD', function()
      if vim.g.use_picker == 'snacks.picker' then
        require 'snacks'.picker.lsp_declarations()
      elseif vim.g.use_picker == 'fzf-lua' then
        require 'fzf-lua'.lsp_declarations()
      end
    end, { buffer = true, desc = 'LSP Declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { buffer = true, silent = true })
  elseif client.supports_method('textDocument/definition') then
    vim.keymap.set('n', 'gD', function()
      if vim.g.use_picker == 'snacks.picker' then
        require 'snacks'
        picker.lsp_definitions()
      elseif vim.g.use_picker == 'fzf-lua' then
        require 'fzf-lua'.lsp_definitions()
      end
    end, { buffer = true, desc = 'LSP Definition' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, silent = true })
  else
  end

  if client.supports_method('textDocument/inlayHint') then
    vim.keymap.set({ 'n', 'i' }, '<M-i>',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = 'Toggle inlay hints' })
  end


  if client.supports_method('textDocument/implementation') then
    vim.keymap.set('n', '<space>li', vim.lsp.buf.implementation, { desc = 'LSP implementation' })
  end

  if client.supports_method('textDocument/references') then
    vim.keymap.set('n', 'gR', function()
      if vim.g.use_picker == 'snacks.picker' then
        require 'snacks'.picker.lsp_references { includeDeclaration = false }
      elseif vim.g.use_picker == 'fzf-lua' then
        require 'fzf-lua'.lsp_references { includeDeclaration = false }
      end
    end, { buffer = true, desc = 'LSP References' })
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references { includeDeclaration = false } end,
      { desc = 'LSP References' })
  end

  if client.supports_method('textDocument/codeLens') then
    codelens(bufnr, lsp_group)
  end

  if client.supports_method("textDocument/formatting") then
    formatting(bufnr)
  end

  if client.supports_method('textDocument/diagnostic') or client.name == 'metals' then
    -- <c-w>d
    diagnostics(bufnr)
  end
end

function M.client_capabilities()
  local capabilities = nil
  local has_blink, blink = pcall(require, 'blink.cmp')

  if has_blink then
    capabilities = blink.get_lsp_capabilities()
  else
    capabilities = vim.lsp.protocol.make_client_capabilities()
  end

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true -- broadcasting snippet capability for completion
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  return capabilities
end

return M
