local M = {}

local codelens = function(client, bufnr, au_group)
  vim.keymap.set('n', '<space>ll',
    function()
      if client.name == 'rust_analyzer' then
        vim.cmd.RustLsp('hover')
      else
        vim.lsp.codelens.run()
      end
    end, { buffer = true, desc = 'Run Codelens' })

  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter' }, {
    group = au_group,
    buffer = bufnr,
    desc = 'Refresh code lens for supported languages',
    callback = function()
      vim.lsp.codelens.refresh()
    end
  })
end

local formatting = function(client, bufnr, au_group)
  local conform_format = function()
    require 'conform'.format({
      timeout_ms = 2000,
      bufnr = bufnr,
      async = false,
      lsp_format = "fallback",
      id = client.id,
    })
  end
  -- local lsp_format = function()
  --   vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000, async = false })
  -- end

  vim.keymap.set('n', 'gq', conform_format, { buffer = true, desc = 'Format buffer' })
  vim.keymap.set('n', '<leader>f', conform_format, { buffer = true, desc = 'Format buffer' })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = au_group,
    buffer = bufnr,
    desc = 'Format on save',
    callback = conform_format,
  })
end

function M.on_attach(client, bufnr)
  local lsp_group = vim.api.nvim_create_augroup('LspAttachedGroup', { clear = true })

  if client.supports_method('textDocument/rename') then
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
  end

  if client.supports_method('textDocument/codeAction') then
    vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, { buffer = true, desc = 'LSP Code Action' })
  end

  if client.supports_method('textDocument/declaration') then
    vim.keymap.set('n', 'gD', function()
      require 'fzf-lua'.lsp_declarations({ jump_to_single_result = true })
    end, { buffer = true, desc = 'LSP Declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { buffer = true, silent = true })
  elseif client.supports_method('textDocument/definition') then
    vim.keymap.set('n', 'gD', function()
      require 'fzf-lua'.lsp_definitions({ jump_to_single_result = true })
    end, { buffer = true, desc = 'LSP Definition' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, silent = true })
  else
  end

  if client.supports_method('textDocument/inlayHint') then
    vim.keymap.set({ 'n', 'i' }, '<M-i>',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = 'Toggle inlay hints' })
  end

  if client.supports_method('textDocument/references') then
    vim.keymap.set('n', '<space>lR', function()
      require 'fzf-lua'.lsp_references({
        jump_to_single_result = true, ignore_current_line = true, includeDeclaration = false
      })
    end, { buffer = true, desc = 'LSP References' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP References' })
  end

  if client.supports_method('textDocument/codeLens') then
    codelens(client, bufnr, lsp_group)
  end

  local has_conform, _ = pcall(require, 'conform') -- has LSP as fallback
  if has_conform then
    vim.b.formatexpr = "v:lua.require'conform'.formatexpr()"
  end
  if client.supports_method("textDocument/formatting") or has_conform then
    formatting(client, bufnr, lsp_group)
  end
end

return M
