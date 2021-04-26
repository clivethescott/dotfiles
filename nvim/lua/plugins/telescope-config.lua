local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

require('telescope').setup{
}

map('n', '<c-p>', ':Telescope find_files<cr>', opts)
map('n', '<c-e>', ':Telescope buffers<cr>', opts)
map('n', '<leader>R', ':Telescope live_grep<cr>', opts)
