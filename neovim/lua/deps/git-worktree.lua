local get_worktrees = function()
  local handle = io.popen("git worktree list")
  if handle == nil then
    return {}
  end
  local result = handle:read("*a")
  handle:close()

  local worktrees = {}
  for line in result:gmatch("[^\r\n]+") do
    -- Each line format: "/path/to/worktree  commit [branch]"
    local path, commit, branch = line:match("^(%S+)%s+(%S+)%s+%[(.+)%]")
    if path then
      table.insert(worktrees, {
        branch = branch,
        path = path,
      })
    end
  end
  return worktrees
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
      function(choice)
        require "git-worktree".switch_worktree(choice.branch)
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
