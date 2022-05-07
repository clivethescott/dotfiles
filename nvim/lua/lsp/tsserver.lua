local M = {}

M.setup = function(on_attach, capabilities)

  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  lspconfig.tsserver.setup {
    capabilities = capabilities;
    on_attach = on_attach;
    root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
  }

end

return M
