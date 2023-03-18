-- Use , as leader, define as early as possible
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Package Manager
require 'plug.lazy'

-- vim.lsp.set_log_level "debug"
require 'helper.utils'
require 'helper.usercommands'

-- Common configuration
require 'conf.options'
require 'conf.autocommands'
require 'conf.abbreviations'
require 'conf.keymaps'

-- Plugin configuration

-- Status line
require 'plug.lualine'
-- File Browser
require 'plug.nvimtree'
-- Icons
require 'plug.webicons'
-- Signs for Git tracked files
require 'plug.gitsigns'
-- Multi-purpose picker
require 'plug.telescope'
-- Syntax parser
require 'plug.treesitter'
-- LSP client config
require 'lsp.lsps'
-- Colorscheme changes, overrides etc
require 'plug.colors'
-- Comments for every language
require 'plug.comment'
-- Snippets engine
require 'plug.luasnip'
-- Toggle Floating terminal
require 'plug.toggleterm'
-- Diagnostics browser
require 'plug.trouble'
-- Complete all sorts of pairs
require 'plug.autopairs'
-- Dim code blocks not in use
require 'plug.twilight'
require 'plug.zen-mode'
-- Override vim.ui.input and vim.ui.select
require 'plug.dressing'
-- Smooth scrolling
require 'plug.neoscroll'
-- Visualize undo history
require 'plug.undotree'
-- Fancy notifications
require 'plug.notify'
-- Visualize marks
require 'plug.marks'
-- Visualize marks
require 'plug.leap'
-- Configure file type associations
require 'plug.filetype'
