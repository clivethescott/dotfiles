require('options')
require('keymaps')
-- Plug Configuration
require('plugins')
require('plugins.plugins-config')
require('plugins.colors-config')
require('plugins.telescope-config')
require('telescope').load_extension('flutter')
require('plugins.treesitter-config')
require('plugins.fugitive-config')
require('plugins.statusline-config')
require('plugins.rnvimr-config')
require('plugins.vimgo-config')
-- LSP
require('lsp-config')
require('plugins.compe-config')
require('plugins.vsnip-config')
require('autogroups')

