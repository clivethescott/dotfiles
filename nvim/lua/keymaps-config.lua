-- Use , as leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

local map = vim.keymap.set
local opts = { remap = false, silent = true }

-- Dealing with word wrap on long lines
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center search result
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', '#', '#zz', opts)
map('n', '*', '*zz', opts)

-- Remove search highlight
map('n', '<leader>m', ':silent! nohls<cr>', opts)

-- Alternate buffer
map('n', '<tab>', ':b#<cr>', opts)

-- Split movements
map('n', '<c-h>', '<c-w>h', opts)
map('n', '<c-j>', '<c-w>j', opts)
map('n', '<c-k>', '<c-w>k', opts)
map('n', '<c-l>', '<c-w>l', opts)

-- Resize v-splits
map('n', '<space><', '10<c-w><', opts)
map('n', '<space>>', '10<c-w>>', opts)

-- Saving
map('n', '<c-s>', ':w<cr>', opts)
map('i', '<c-s>', '<esc>:w<cr>', opts)

-- Jump to exact mark position either way
map('n', "'", "`", opts)

-- Faster way to quit
map('n', 'Q', ':q<cr>', opts)

-- Faster way to yank line
map('n', 'Y', 'yy', opts)

-- Shouldn't be using these anyway
map('n', '<left>', '<nop>', opts)
map('v', '<left>', '<nop>', opts)
map('n', '<right>', '<nop>', opts)
map('v', '<right>', '<nop>', opts)
map('n', '<down>', '<nop>', opts)
map('v', '<down>', '<nop>', opts)
map('n', '<up>', '<nop>', opts)
map('v', '<up>', '<nop>', opts)

-- Keep indent/outdent after first indent/outdent in visual mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Telescope mappings
local telescope = require('telescope.builtin')
map('n', '<c-e>', telescope.buffers)
-- Use git_files if in git dir, else use find_files
map('n', '<c-p>', require('telescope-keymaps').project_files)
map('n', '<leader>t', telescope.builtin)
map('n', '<leader>tf', telescope.live_grep)
map('n', '<leader>tb', telescope.current_buffer_fuzzy_find)
map('n', '<leader>tc', telescope.commands)
map('n', '<leader>tm', telescope.marks)
map('n', '<leader>tj', telescope.jumplist)
map('n', '<leader>tr', telescope.registers)
map('n', '<leader>tk', telescope.keymaps)
-- map('n', '<space>fs', telescope.spell_suggest)
map('n', '<leader>gc', telescope.git_commits)
map('n', '<leader>gb', telescope.git_bcommits)
map('n', '<leader>gg', telescope.git_branches)
map('n', '<leader>gs', telescope.git_status)
map('n', '<leader>go', telescope.oldfiles)
-- map('n', '<space>ts', telescope.treesitter)
-- map('n', '<leader>sh', telescope.help_tags)
-- map('n', '<leader>st', telescope.tags)
-- map('n', '<space>fs', telescope.grep_string)
-- map('n', '<leader>so', function()
--   telescope.tags { only_current_buffer = true }
-- end)

-- NvimTree mappings
local tree = require('nvim-tree')
map('n', '<leader>1', tree.toggle)

-- Metals mappings
local metals = require 'metals'
local tvp = require 'metals.tvp'
map('n', '<space>wo', metals.hover_worksheet)
map('n', '<space>to', tvp.reveal_in_tree)
map('n', '<space>tt', tvp.toggle_tree_view)

-- User Commands
local utils = require 'utils'
map('n', '<leader>gb', utils.gitBlame)
map('n', '<leader>gB', utils.gitBlameClear)
