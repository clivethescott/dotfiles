---@class Worktree
---@field branch string The name of the branch
---@field path string Path to where the worktree is

---@return Worktree[]
local get_worktrees = function()
  if Snacks.git.get_root() == nil then
    vim.notify('Not in a Git repo', vim.log.levels.WARN)
    return {}
  end
  local worktrees = vim.fn.systemlist({ "git", "worktree", "list" })
  return vim.tbl_map(function(tree)
    -- path, commit, branch
    local path, _, branch = tree:match("^(%S+)%s+(%S+)%s+%[(.+)%]")
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
          return item.branch .. ' ' .. vim.fn.expand(item.path, ":p:h:t")
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
  config = true,
  keys = {
    { "<space>gw", select_worktree, desc = 'Switch worktree' }
  }
}
