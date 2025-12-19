vim.keymap.set('n', '<C-s>', '<cmd>update<cr>')
vim.keymap.set('i', '<C-s>', '<esc>:update<cr>')
vim.keymap.set('i', '<C-z>', '<esc>:undo<cr>')

vim.keymap.set('n', '<M-v>', '"*p')
vim.keymap.set('i', '<M-v>', '<esc>"*p')
vim.keymap.set({ 'n', 'v', 's' }, '<M-y>', '"*y')

vim.keymap.set('n', '<leader>e', function() vim.show_pos() end, { desc = 'Show highlight at cursor' })

vim.keymap.set("n", "k", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "k"
end, { expr = true })

vim.keymap.set("n", "j", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "j"
end, { expr = true })

vim.keymap.set('n', '<space>lD', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })

vim.keymap.set('n', 'Q', ':q<cr>')
vim.keymap.set('n', '<leader>q', ':qa!<cr>')
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', '<space>y',
  function()
    local file_name = vim.fn.expand('%:t')
    vim.fn.setreg(vim.v.register, file_name)
    vim.notify('Copied file name "' .. file_name .. '" to clipboard')
  end, { desc = 'Yank file name' })

-- Resize split
-- :vertical resize +10 OR :vertical resize 90

-- Keep selection after visual indent/outdent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Lua dev
vim.keymap.set('n', '<space>x', ":.lua<cr>", { silent = true, desc = 'Exec Lua' })
vim.keymap.set('n', '<space>X', "<cmd>source %<cr>", { silent = true, desc = 'Exec Lua file' })
vim.keymap.set('v', '<space>x', ":lua<cr>", { silent = true, desc = 'Exec Lua' })

-- See :h & and :h &&
vim.keymap.set({ 'x', 'n' }, '&', ':&&<cr>', { desc = 'Repeat last substitute keeping flags' })

-- use the default <c-l> to clear search highlight
-- vim.keymap.set('n', '<leader>m', "<cmd>silent! nohls<cr>", { silent = true, desc = 'Clear highlight' })

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
