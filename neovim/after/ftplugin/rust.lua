vim.cmd [[setlocal makeprg=cargo\ build]]
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.keymap.set({ 'n', 'i', 'v' }, '<c-b>',
  function()
    require 'snacks'.terminal.open('cargo check', { interactive = false })
  end,
  { desc = "Cargo build" })
