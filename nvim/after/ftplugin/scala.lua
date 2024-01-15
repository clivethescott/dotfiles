local opts = { silent = true, noremap = true, buffer = true }

local build = function()
  require 'toggleterm'.exec("scala-cli -q .")
end
vim.keymap.set('n', '<C-b>', build, opts)
