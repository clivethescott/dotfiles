---@type vim.lsp.Config
return {
  root_markers = {'package.json', 'tsconfig.json', 'jsconfig.json'},
  ---@type lspconfig.settings.ts_ls
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
      }
    }
  },
}
