local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>gs', ':G<cr>', opts)
map('n', '<leader>g2', ':diffget //3<cr>', opts)
map('n', '<leader>g3', ':diffget //3<cr>', opts)
map('n', '<leader>g1', ':diffget //1<cr>', opts)
map('n', '<leader>gc', ':G commit<cr>', opts)
map('n', '<leader>gk', ':wincmd c | Dispatch git push<cr>', opts)
map('n', '<leader>gp', ':Dispatch git pull --ff<cr>', opts)
map('n', 'nnoremap <leader>gl', ':G log<cr>', opts)
