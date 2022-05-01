local telescope = require('telescope.builtin')
local M = {}

M.project_files = function()
  local fopts = {
    hidden = true,
    no_ignore = false
  }
  local ok = pcall(telescope.git_files, fopts)
  if not ok then telescope.find_files(fopts) end
end

return M
