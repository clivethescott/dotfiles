vim.cmd[[setlocal makeprg=cargo\ run]]
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

local default_opts = { silent = true, noremap = true }
local map = function(mode, lhs, rhs, opts)
  if opts then
    vim.tbl_extend('keep', opts, default_opts)
  else
    opts = default_opts
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.cmd[[command! -count=1 CargoRun lua require'toggleterm'.exec("cargo run", <count>, 12)]]
map('n', '<C-b>', ':CargoRun<cr>')
