-- Use , as leader, define as early as possible
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Package Manager
require 'pkg.lazy'
--
-- vim.lsp.set_log_level "debug"
require 'helper.utils'
require 'helper.usercommands'
--
-- -- Common configuration
require 'conf.colors'
require 'conf.options'
require 'conf.autocommands'
require 'conf.abbreviations'
