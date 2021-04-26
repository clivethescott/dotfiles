-- TODO: set git branch
-- vim.g.lightline = {
--   colorscheme = 'jellybeans',
--   component_function = {
--   gitbranch = 'FugitiveHead',
--   },
-- }
require('lualine').setup{
  options = {
    theme = 'gruvbox',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
  }
}
