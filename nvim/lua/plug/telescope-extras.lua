local has_telescope, telescope = pcall(require, 'telescope.builtin')
local M = {}

M.project_files = function()
  if not has_telescope then
    return
  end

  local fopts = {
    hidden = true,
    no_ignore = false
  }
  local ok = pcall(telescope.git_files, fopts)
  if not ok then telescope.find_files(fopts) end
end

return M
