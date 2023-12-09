-- See :h netrw-quickmap
--
-- vim.g.netrw_keepdir = false

vim.keymap.set('n', 'O', '<CR>:Lexplore<CR>', { silent = true, buffer = true })
-- close preview
vim.keymap.set('n', 'P', '<C-w>z', { silent = true, buffer = true })
vim.keymap.set('n', '<esc>', '<cr>', { silent = true, buffer = true })
vim.keymap.set('n', 'gp', ':Rexplore<cr>', { silent = true, buffer = true })
