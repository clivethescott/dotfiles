vim.keymap.set('n', '<c-s>', '<cmd>update<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:update<cr>')

vim.keymap.set('n', 'Q', ':q<cr>')
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', '<space>y', ':silent! %y<cr>', { desc = 'Yank buffer' })

-- Keep selection after visual indent/outdentyy
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Lua dev
vim.keymap.set('n', '<space>x', ":.lua<cr>", { silent = true, desc = 'Exec Lua' })
vim.keymap.set('n', '<space>X', "<cmd>source %<cr>", { silent = true, desc = 'Exec Lua' })
vim.keymap.set('v', '<space>x', ":lua<cr>", { silent = true, desc = 'Exec Lua' })

-- Dealing with word wrap on long lines
vim.keymap.set('n', 'k', [[v:count < 2 ? 'gk' : "m'" .. v:count .. 'k']], { expr = true })
vim.keymap.set('n', 'j', [[v:count < 2 ? 'gj' : "m'" .. v:count .. 'j']], { expr = true })

if vim.fn.has("nvim-0.11") ~= 1 then
  -- Quickly add empty lines, provided later in nvim
  -- https://github.com/mhinz/vim-galore#quickly-add-empty-lines=
  vim.keymap.set('n', '[<space>', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", { desc = 'Add line before' })
  vim.keymap.set('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', { desc = 'Add line after' })
end

-- Misc
vim.keymap.set('n', '<space><space>', ":b#<cr>", { silent = true, desc = 'Alt buffer' })
vim.keymap.set('n', '<leader>m', "<cmd>silent! nohls<cr>", { silent = true, desc = 'Clear highlight' })
