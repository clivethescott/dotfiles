local opts = { silent = true, noremap = true, buffer = true }
local build = function()
  require 'toggleterm'.exec("go run .")
end
vim.keymap.set('n', '<C-b>', build, opts)
