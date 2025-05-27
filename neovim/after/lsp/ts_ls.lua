return {
  root_dir = require 'lspconfig'.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
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
