return {
  root_markers = {'package.json', 'tsconfig.json', 'jsconfig.json'},
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
