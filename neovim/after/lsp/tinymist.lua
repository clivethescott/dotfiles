---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.tinymist
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onSave",
    semanticTokens = "disable",
  },
}
