local M = {}
M.setup = function(on_attach, capabilities)

  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end
  lspconfig.html.setup {
    capabilities = capabilities;
    on_attach = on_attach;
  }
end
return M
