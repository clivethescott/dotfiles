-- Make Ranger replace netrw and be the file explorer
vim.g.rnvimr_ex_enable = 1
-- Hide the files included in gitignore
vim.g.rnvimr_hide_gitignore = 1
-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
vim.g.rnvimr_enable_bw = 1
-- Map Rnvimr action
vim.g.rnvimr_action = {
  ['<C-s>'] = 'NvimEdit split',
  ['<C-t>'] = 'NvimEdit vsplit',
  gw = 'JumpNvimCwd',
  yw = 'EmitRangerCwd'
}

local columns = math.max(vim.o.columns, 80)
local lines = vim.o.lines 
-- Customize the initial layout
vim.g.rnvimr_layout = {
  relative = 'editor',
  width = math.floor(0.8 * columns),
  height = math.floor(0.7 * lines),
  col = math.floor(0.15 * columns),
  row = math.floor(0.15 * lines),
  style = 'minimal'
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>1', ':RnvimrToggle<cr>', opts)
map('t', '<leader>1', [[<C-\><C-n>:RnvimrToggle<cr>]], opts)
