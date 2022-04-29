-- Use , as leader, define as early as possible
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- vim.lsp.set_log_level("debug")
require('config.utils')
require('config.packer-config')
require('config.options-config')
require('config.autogroups')
require('config.abbreviations')

require('config.lualine-config')
require('config.nvimtree-config')
require('config.webicons-config')

require('config.keymaps-config')
require('config.gitsigns-config')
require('config.telescope-config')
require('config.treesitter-config')
require('config.lsps-config')
-- require('config.metals-config')
require('config.colors-config')
require('config.comment-config')
require('config.autogroups')
require('config.commands')
require('config.luasnip-config')
require('config.dap-config')
require('config.toggleterm-config')
require('config.trouble-config')
require('config.autopairs-config')

require('config.twilight-config')
require('config.zen-mode-config')
require('config.dressing-config')
