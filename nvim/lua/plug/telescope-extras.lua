local has_telescope, telescope = pcall(require, 'telescope.builtin')
local M = {}

M.project_files = function()
  if not has_telescope then
    return
  end

  local fopts = {
    hidden = true,
    no_ignore = false,
    show_untracked = true
  }
  local is_git_dir = require 'telescope.utils'.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })[1]
  if is_git_dir then
    telescope.git_files(fopts)
  else
    telescope.find_files(fopts)
  end
end

return M
