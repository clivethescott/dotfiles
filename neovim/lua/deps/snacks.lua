local show_git = function()
  local git_root = Snacks.git.get_root() or ''
  local match = string.find(git_root, 'subscription-service', 1, true) or
      string.find(git_root, 'registry', 1, true) or
      0
  return match > 0
end
---@type snacks.dashboard.Section
local dashboard_sections = {
  { section = "header" },
  { section = "keys", gap = 0.5, padding = 1 },
  { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
  {
    pane = 2,
    icon = " ",
    title = "Git Status",
    section = "terminal",
    enabled = show_git,
    cmd = "git status --short --branch --renames",
    height = 3,
    padding = 1,
    ttl = 5 * 60,
    indent = 3,
  },
  {
    pane = 1,
    icon = " ",
    section = "terminal",
    title = "Open PRs",
    cmd = 'gh pr list -L 5 --author "@me"',
    key = "P",
    enabled = show_git,
    ttl = 1 * 60,
    action = function()
      vim.fn.jobstart('gh pr list --author "@me" --web', { detach = true })
    end,
    height = 10,
    width = 150,
  },
  { section = "startup" },
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      width = 70,
      sections = dashboard_sections,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "F", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "o", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        }
      }
    },
    lazygit = { enabled = true },
    bigfile = { enabled = true },
    notifier = { enabled = true },
    image = { enabled = true },
  },
  keys = {
    { "gs",        function() require 'snacks'.lazygit.open() end,                  desc = "Lazygit" },
    { "<space>nh", function() require 'snacks'.notifier.show_history() end, desc = "Notification history" },
  }
}
