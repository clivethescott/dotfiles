local M = {}
M.setup = function(on_attach, capabilities)

  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  lspconfig.pyright.setup {
    capabilities = capabilities;
    on_attach = on_attach;
    settings = {
      python = {
        analysis = {
          loglevel = 'Error',
          typeCheckingMode = 'strict'
        }
      }
    }
  }
end

return M
