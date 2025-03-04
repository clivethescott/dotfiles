vim.keymap.set('n', '<c-s>', '<cmd>update<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:update<cr>')

vim.keymap.set('n', 'Q', ':q<cr>')
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', '<space>y', ":let @+=expand('%:t')<cr>", { desc = 'Yank file name'})
vim.keymap.set('n', '<space>Y', ':%y<cr>', { desc = 'Yank buffer', silent = true })
vim.keymap.set({ 'n', 'v' }, '<space>p', '"*p', { desc = 'Paste from sys clipboard', silent = true })

-- Resize split
-- :vertical resize +10 OR :vertical resize 90

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
  vim.keymap.set('n', '[<space>', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[",
    { desc = 'Add line before', silent = true })
  vim.keymap.set('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>',
    { desc = 'Add line after', silent = true })
end

-- Misc
vim.keymap.set('n', '<space><space>', ":b#<cr>", { silent = true, desc = 'Alt buffer' })
vim.keymap.set('n', '<leader>m', "<cmd>silent! nohls<cr>", { silent = true, desc = 'Clear highlight' })
vim.keymap.set('n', '<space>ow',
  function()
    if vim.o.winbar == "" then
      vim.o.winbar = "%{%v:lua.require'utils'.nvim_winbar()%}"
    else
      vim.o.winbar = ""
    end
  end, { desc = 'Toggle Winbar' })

-- quickfix
vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', { desc = 'Prev Quickfix entry' })
vim.keymap.set('n', '[Q', '<cmd>cNfile<cr>', { desc = 'Quickfix last file' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Next Quickfix entry' })
vim.keymap.set('n', ']Q', '<cmd>cnfile<cr>', { desc = 'Quickfix next file' })
