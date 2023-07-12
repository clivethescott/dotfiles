vim.cmd[[setlocal makeprg=cargo\ run]]
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

local opts = { silent = true, noremap = true, buffer = true }

local build = function()
  require 'toggleterm'.exec("cargo run")
end
vim.keymap.set('n', '<C-b>', build, opts)
