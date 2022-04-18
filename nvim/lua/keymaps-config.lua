vim.g.mapleader = ','
vim.g.maplocalleader = ','

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remove search highlight
map('n', '<leader>m', ':silent! nohls<cr>', opts)

-- Alternate buffer
map('n', '<tab>', ':b#<cr>', opts)

-- Split movements in all modes
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

-- We shouldn't be using these anyway
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
map('n', '<c-p>', require('telescope-keymaps').project_files)
map('n', '<space>ff', telescope.live_grep)
map('n', '<space>fb', telescope.current_buffer_fuzzy_find)
map('n', '<space>fc', telescope.commands)
map('n', '<space>fm', telescope.marks)
map('n', '<space>fj', telescope.jumplist)
map('n', '<space>fr', telescope.registers)
map('n', '<space>fs', telescope.spell_suggest)
map('n', '<space>fk', telescope.keymaps)
map('n', '<space>gc', telescope.git_commits)
map('n', '<space>gb', telescope.git_bcommits)
map('n', '<space>gg', telescope.git_branches)
map('n', '<space>gs', telescope.git_status)
map('n', '<space>ts', telescope.treesitter)
map('n', '<space>t', telescope.builtin)
-- map('n', '<leader>sh', telescope.help_tags)
-- map('n', '<leader>st', telescope.tags)
-- map('n', '<space>fs', telescope.grep_string)
-- map('n', '<leader>so', function()
--   telescope.tags { only_current_buffer = true }
-- end)
-- map('n', '<leader>?', telescope.oldfiles)

-- NvimTree mappings
local tree = require('nvim-tree')
map('n', '<leader>1', tree.toggle)

-- Metals mappings
local metals = require 'metals'
map('n', '<space>wo', metals.hover_worksheet)

-- User Commands
local utils = require'utils'
map('n', '<leader>gb', utils.gitBlame)
map('n', '<leader>gB', utils.gitBlameClear)
