vim.g.netrw_banner = 0
-- tree style listing
-- vim.g.netrw_liststyle = 3 -- toggle with 'i'
-- :h netrw_bufsettings
vim.g.netrw_bufsettings = 'noma nomod ro nobl nowrap number relativenumber'
vim.g.netrw_winsize = 50
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]() .. ",*.pdf,*.exe"

-- tried using g:netrw_localmovecmd<mv>; it doesn't work!
-- vim.g.netrw_keepdir = 0

-- enable recursive copy of directories.
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_localrmdir = 'rm -r'
-- open files in a vsplit
vim.g.netrw_browse_split = 0
-- preview in right vsplit
vim.g.netrw_preview = 1
vim.g.netrw_alto = 1

vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<cr>', { desc = 'Toggle Netrw' })
vim.keymap.set('n', '<leader>E', '<cmd>Lexplore %:p:h<cr>', { desc = 'Netrw in parent dir' })
vim.keymap.set('n', '<M-h>', '-', { desc = 'Up dir', remap = true })
vim.keymap.set('n', '<M-l>', '<cr>', { desc = 'Down dir', remap = true })
vim.keymap.set('n', '<leader>m', function()
  vim.cmd [[echo join(netrw#Expose("netrwmarkfilelist"), "\n")]]
end, { desc = 'Print mark list', remap = true })
