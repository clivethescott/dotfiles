---@type vim.lsp.Config
return {
---@type lspconfig.settings.pyright
  settings = {
    python = {
      analysis = {
        loglevel = 'Error',
        typeCheckingMode = 'strict'
      }
    }
  }
}
