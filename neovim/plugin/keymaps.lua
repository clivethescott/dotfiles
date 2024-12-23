vim.keymap.set('n', '<c-s>', ':update<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:update<cr>')

vim.keymap.set('n', 'Q', ':q<cr>')
vim.keymap.set('n', 'Y', 'yy')

-- Keep selection after visual indent/outdent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Lua dev
vim.keymap.set('n', '<space>x', ":.lua<cr>", { silent = true })
vim.keymap.set('n', '<space>X', "<cmd>source %<cr>", { silent = true })
vim.keymap.set('v', '<space>x', ":lua<cr>", { silent = true })

vim.keymap.set('n', 'gp', ":b#<cr>", { silent = true })
