---@type vim.lsp.Config
return {
  init_options = {
    ---@type lspconfig.settings.ruff_lsp
    settings = {
      logLevel = 'error',
    }
  }
}
