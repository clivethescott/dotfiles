local M = {}
M.setup = function(on_attach, capabilities)
  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  lspconfig.gopls.setup {
    capabilities = capabilities;
    filetypes = { 'go' };
    on_attach = function(client, bufnr)
      -- These will be handled by null-ls goimports
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end;
  }
end

return M
