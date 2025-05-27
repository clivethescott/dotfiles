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

local formatting = function(client, bufnr)
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require 'conform'.format({
      timeout_ms = 2000,
      bufnr = bufnr or 0,
      async = false,
      lsp_format = "fallback",
      id = client.id,
    })
  end, { buffer = true, desc = 'LSP Format' })
end

local diagnostics = function(bufnr)
  vim.keymap.set('n', '<space>ld',
    function() vim.diagnostic.setqflist() end,
    { desc = 'LSP Diagnostics to qflist', buffer = bufnr })

  vim.keymap.set('n', '<leader>d',
    function() vim.diagnostic.open_float({ scope = 'line' }) end,
    { desc = 'Line Diagnostic', buffer = bufnr })

  vim.keymap.set('n', '[e',
    function()
      vim.diagnostic.jump {
        count = -1,
        wrap = false,
        severity = { min = vim.diagnostic.severity.WARN }
      }
    end, { desc = 'Prev Warning or Error', buffer = bufnr })

  vim.keymap.set('n', ']e',
    function()
      vim.diagnostic.jump {
        count = 1,
        wrap = true,
        severity = { min = vim.diagnostic.severity.WARN }
      }
    end,
    { desc = 'Next Warning or Error', buffer = bufnr })
end

function M.on_attach(client, bufnr)
  local lsp_group = vim.api.nvim_create_augroup('LspAttachedGroup', { clear = true })

  if client.name == 'copilot' then return end

  -- Prefer LSP folding if client supports it
  -- :h vim.lsp.foldexpr
  if client:supports_method('textDocument/foldingRange') then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end

  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
  end


  if client:supports_method('textDocument/signatureHelp') then
    vim.keymap.set({ 'n', 'i' }, '<M-s>', vim.lsp.buf.signature_help, { buffer = true, desc = 'Signature help' })
    -- default vim.keymap.set('i', '<c-s>',vim.lsp.buf.signature_help)
  end


  if client.supports_method('textDocument/rename') then
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
    -- default vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
  end

  if client.supports_method('textDocument/codeAction') then
    vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, { buffer = true, desc = 'LSP Code Action' })
    -- default vim.keymap.set('n', 'gra', vim.lsp.code_action)
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
        require 'snacks'.picker.lsp_definitions()
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
    -- default vim.keymap.set('n', 'gri', vim.lsp.buf.implementation)
  end

  if client.supports_method('textDocument/references') then
    -- default vim.keymap.set('n', 'grr', vim.lsp.buf.references)
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

  local has_conform, _ = pcall(require, 'conform') -- has LSP as fallback
  if has_conform then
    vim.b.formatexpr = "v:lua.require'conform'.formatexpr()"
  end
  if client.supports_method("textDocument/formatting") or has_conform then
    formatting(client, bufnr)
  end

  if client.supports_method('textDocument/diagnostic') or client.name == 'metals' then
    -- <c-w>d
    diagnostics(bufnr)
  end
end

function M.client_capabilities()
  local has_blink, blink = pcall(require, 'blink.cmp')

  local capabilities     = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      },
      semanticTokens = {
        multilineTokenSupport = true,
      },
      completionitem = {
        snippetSupport = true,
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" }
        }
      }
    }
  }
  if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
  else
    capabilities = vim.tbl_deep_extend('force', capabilities, vim.lsp.protocol.make_client_capabilities())
  end

  return capabilities
end

return M
