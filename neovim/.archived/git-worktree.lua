---@class Worktree
---@field branch string The name of the branch
---@field path string Path to where the worktree is

---@param file string
local has_root_file = function(file)
  local file_path = vim.fs.joinpath(vim.fn.getcwd(), file)
  return vim.uv.fs_stat(file_path) ~= nil
end

---@return Worktree[]
local get_worktrees = function()
  if Snacks.git.get_root() == nil then
    vim.notify('Not in a Git repo', vim.log.levels.WARN)
    return {}
  end
  local git_worktrees = vim.fn.systemlist({ "git", "worktree", "list" })
  local worktrees = vim.tbl_filter(function(item)
    return string.find(item, 'bare', 1, true) == nil
  end, git_worktrees)
  return vim.tbl_map(function(tree)
    -- path, commit, branch
    local path, _, branch = tree:match("^(%S+)%s+(%S+)%s+[%(%[](.+)[%)%]]")
    return {
      branch = branch or 'unknown',
      path = path or 'unknown',
    }
  end, worktrees)
end

local select_worktree = function()
  local worktrees = get_worktrees()
  if #worktrees > 0 then
    vim.ui.select(worktrees,
      {
        prompt = 'Select worktree',
        format_item = function(item)
          return vim.fn.fnamemodify(item.path, ":t")
        end
      },
      function(tree)
        if tree ~= nil then
          require "git-worktree".switch_worktree(tree.branch)
        end
      end)
  end
end

return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local Job = require 'plenary.job'
    local wt = require('git-worktree')
    wt.setup()

    wt.on_tree_change(function(op, path, upstream)
      if (op == "switch" or op == "create") and has_root_file('build.sbt') then
        Job:new({
          command = 'sbtn',
          args = { 'compile' },
          cwd = vim.fn.getcwd(),
          env = { ['a'] = 'b' },
          on_exit = function(j, return_val)
            print(return_val)
            print(j:result())
          end,
        }):start()
        vim.notify('Compiling SBT project', vim.log.levels.INFO)
      end
    end)
  end,
  keys = {
    { "<space>gw", select_worktree, desc = 'Switch worktree' }
  }
}
