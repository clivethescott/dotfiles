local opts = { silent = true, noremap = true, buffer = true }

local build = function()
  require 'toggleterm'.exec("sbtn compile")
end
vim.keymap.set('n', '<C-b>', build, opts)
