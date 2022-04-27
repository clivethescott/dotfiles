-- Use , as leader, define as early as possible
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- vim.lsp.set_log_level("debug")
require('utils')
require('packer-config')
require('options-config')
require('autogroups')
require('abbreviations')

require('lualine-config')
require('nvimtree-config')
require('webicons-config')

require('keymaps-config')
require('gitsigns-config')
require('telescope-config')
require('treesitter-config')
require('lsps-config')
-- require('metals-config')
require('colors-config')
require('comment-config')
require('autogroups')
require('commands')
require('luasnip-config')
require('dap-config')
require('toggleterm-config')
require('trouble-config')
require('autopairs-config')

require('twilight-config')
require('zen-mode-config')
require('dressing-config')
