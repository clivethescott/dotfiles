local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','

local opts = { noremap = true, silent = true }

map('n', '<leader>c', ':cclose<cr>', opts)
map('n', '<leader>m', ':silent! nohls<cr>', opts)
map('n', '<leader>2', ':e ~/.config/nvim/init.lua<cr>', opts)
map('n', '<leader>3', ':e ~/.config/nvim/lua/options.lua<cr>', opts)
map('n', '<leader>4', ':Startify<cr>', opts)
map('n', '<leader>b', ':make<cr>', opts)
map('n', '<tab>', ':b#<cr>', opts)
-- Split movements in all modes
map('n', '<c-h>', '<c-w>h', opts)
map('n', '<c-j>', '<c-w>j', opts)
map('n', '<c-k>', '<c-w>k', opts)
map('n', '<c-l>', '<c-w>l', opts)
-- Resize v-splits
map('n', '<leader><', '10<c-w><', opts)
map('n', '<leader>>', '10<c-w>>', opts)
-- Saving
map('n', '<c-s>', ':w<cr>', opts)
map('i', '<c-s>', '<esc>:w<cr>', opts)
-- Jump to exact mark position either way
map('n', "'", "`", opts)
map('n', 'Q', ':q<cr>', opts)
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
map('n', '<leader>gh', ':helptags ALL<cr>', opts)
map('n', 'g>', ':diffput<cr>', opts)
map('n', 'g<', ':diffget<cr>', opts)
map('n', 'tn', ':tabnext<cr>', opts)
map('n', 'tp', ':tabprevious<cr>', opts)
map('n', 'tN', ':tabnew<cr>', opts)
map('n', 'tc', ':tabclose<cr>', opts)

-- Split Window movements
map('n', '<c-h>', '<c-w>h', opts)
map('n', '<c-j>', '<c-w>j', opts)
map('n', '<c-k>', '<c-w>k', opts)
map('n', '<c-l>', '<c-w>l', opts)

-- Faster Saving
map('n', '<c-s>', ':w<cr>', opts)
map('i', '<c-s>', '<esc>:w<cr>', opts)

