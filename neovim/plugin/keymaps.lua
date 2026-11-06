vim.keymap.set('n', '<C-s>', ':silent update<cr>')
vim.keymap.set('i', '<C-s>', '<esc>:silent update<cr>')

vim.keymap.set('i', '<C-z>', '<esc>:undo<cr>')

vim.keymap.set('n', '<M-v>', '"*p')
vim.keymap.set({ 'n', 'v', 's' }, '<M-y>', '"*y')
vim.keymap.set('i', '<M-v>', '<esc>"*p')
vim.keymap.set('n', 'gh', '<cmd>:help!<cr>', { desc = 'Improved help' })

-- use :Inspect
-- vim.keymap.set('n', '<leader>t', vim.show_pos, { desc = 'Show highlight at cursor' })

vim.keymap.set("n", "k", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "k"
end, { expr = true })

vim.keymap.set("n", "j", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "j"
end, { expr = true })

vim.keymap.set('n', '<space>lD', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })

--  :q! / built-in ZQ
--  :restart / built-in ZR
--  :wq / built-in ZZ
vim.keymap.set('n', '<space>q', function()
  local winid = vim.fn.bufwinid(0) or 0
  vim.lsp.foldclose('comment', winid)
  vim.lsp.foldclose('imports', winid)
end)
vim.keymap.set({ 'n', 'v' }, '<c-/>', 'gcc', { remap = true })
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

vim.keymap.set('n', '<leader>m', vim.snippet.stop,
  { silent = true, desc = 'Clear snippet highlight' })

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

-- use built-in V_il and V_al for select line and select whole buffer
-- Whole buffer text object
-- vim.keymap.set('o', 'ig', ':<C-u>normal! ggVG<CR>', { desc = 'Inner whole buffer' })
-- vim.keymap.set('o', 'ag', ':<C-u>normal! ggVG<CR>', { desc = 'Around whole buffer' })
-- vim.keymap.set('x', 'ig', ':<C-u>normal! ggVG<CR>', { desc = 'Inner whole buffer' })
-- vim.keymap.set('x', 'ag', ':<C-u>normal! ggVG<CR>', { desc = 'Around whole buffer' })

vim.keymap.set('n', '<space>ol', function()
  vim.pack.update(nil, { force = false })
end, { desc = 'Show packages with updates' })

-- multiple cursors
-- Q add cursor (works in visual selection as well)
-- :s/... then 1Q - place a cursor at every search match
-- g<C-a> Number lines with cursors
-- Follow mode: visual mode enables “follow-mode” by default
-- 1q= - enable follow mode
-- 2q= - exit follow mode
-- Jump between cursors: [C and ]C
-- gQ restores the previous set of multiple cursors
-- Registers: cursors have their own registers.
-- https://blog.olimorris.com/2026/09/02/multiple-cursors-in-neovim-0.13
