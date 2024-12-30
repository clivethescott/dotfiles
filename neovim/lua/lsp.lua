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
  local format = function()
    vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000, async = false })
  end
  vim.keymap.set('n', 'gq', format, { buffer = true, desc = 'Format buffer' })
  vim.keymap.set('n', '<leader>f', format, { buffer = true, desc = 'Format buffer' })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = au_group,
    buffer = bufnr,
    desc = 'Format on save',
    callback = format,
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

  if client.supports_method('textDocument/references') then
    vim.keymap.set('n', '<space>lR', function()
      require 'fzf-lua'.lsp_references()
    end, { buffer = true, desc = 'LSP References' })
  end

  if client.supports_method('textDocument/codeLens') then
    codelens(client, bufnr, lsp_group)
  end

  if client.supports_method("textDocument/formatting") then
    -- vim.api.keymap.set({'n', 'v'}, 'gq', vim.lsp.buf.format) -- provided
    formatting(client, bufnr, lsp_group)
  end
end

return M
