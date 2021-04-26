local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

require('telescope').setup{
}

map('n', '<c-p>', ':Telescope find_files<cr>', opts)
map('n', '<c-e>', ':Telescope buffers<cr>', opts)
map('n', '<leader>R', ':Telescope live_grep<cr>', opts)
map('n', '<space>go', ':Telescope oldfiles<cr>', opts)
map('n', '<space>gm', ':Telescope marks<cr>', opts)
map('n', '<space>gr', ':Telescope registers<cr>', opts)
map('n', '<space>ga', ':Telescope lsp_code_actions<cr>', opts)
map('n', '<space>gA', ':Telescope lsp_range_code_actions<cr>', opts)
map('n', '<space>gl', ':Telescope git_commits<cr>', opts)
map('n', '<space>gL', ':Telescope git_bcommits<cr>', opts)
map('n', '<space>gb', ':Telescope git_branches<cr>', opts)
map('n', '<space>gs', ':Telescope git_status<cr>', opts)
