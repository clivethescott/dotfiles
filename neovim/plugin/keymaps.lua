vim.keymap.set('n', '<C-s>', '<cmd>update<cr>')
vim.keymap.set('i', '<C-s>', '<esc>:update<cr>')
vim.keymap.set('i', '<C-z>', '<esc>:undo<cr>')

vim.keymap.set("n", "k", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "k"
end, { expr = true })

vim.keymap.set("n", "j", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "j"
end, { expr = true })

vim.keymap.set('n', '<space>lD', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })

-- Rename terminal without keeping old alt
--https://vi.stackexchange.com/questions/9566/how-to-change-buffer-name-for-neovim-terminal-special-buffer
-- keepalt file newName
vim.keymap.set({ 'n', 't' }, '<leader>R', function()
  vim.ui.input({ prompt = 'Enter new name: ' }, function(name)
    if name ~= nil then
      vim.cmd(':keepalt file ' .. name)
    end
  end)
end)
vim.keymap.set('n', 'Q', ':q<cr>')
vim.keymap.set('n', '<leader>q', ':q!<cr>')
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', '<space>y', ":let @+=expand('%:t')<cr>", { desc = 'Yank file name' })
vim.keymap.set({ 'n', 'v' }, '<space>p', '"*p', { desc = 'Paste from sys clipboard', silent = true })
-- Resize split
-- :vertical resize +10 OR :vertical resize 90

-- Keep selection after visual indent/outdentyy
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Lua dev
vim.keymap.set('n', '<space>x', ":.lua<cr>", { silent = true, desc = 'Exec Lua' })
vim.keymap.set('n', '<space>X', "<cmd>source %<cr>", { silent = true, desc = 'Exec Lua file' })
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
-- default ]q [q [Q ]Q for location list,
-- default ]l [l [L ]L for location list,
-- default ]t [t [T ]T for tag list,
-- default ]b [b for buffer list,

-- nicer :find
function Fd(file_pattern, _)
  -- if first char is * then fuzzy search
  if file_pattern:sub(1, 1) == "*" then
    file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
  end
  local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
  local result = vim.fn.systemlist(cmd)
  return result
end

vim.opt.findfunc = "v:lua.Fd"
