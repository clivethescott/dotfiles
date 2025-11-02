---@diagnostic disable: missing-fields
---@diagnostic disable-next-line: param-type-mismatch
local plugins_dir        = vim.fs.joinpath(vim.fn.stdpath('data'), '/lazy')
local conf_dirs          = { '~/.config/nvim', '~/.config/wezterm', '~/.config/tmux',
  '~/.config/fish', '~/.config/atuin', '~/.config/lazygit' }

---@type snacks.picker.Config
local picker_config      = {
  enabled = vim.g.use_picker == 'snacks.picker',
  win = {
    input = {
      keys = {
        ["<a-i>"] = { "toggle_preview", mode = { "i", "n" } },
        ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
        ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
        ["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
        ["<c-q>"] = { "qflist", mode = { "i", "n" } },
        ["<a-g>"] = { "toggle_ignored", mode = { "i", "n" } },
        ["<a-m>"] = { "toggle_hidden", mode = { "i", "n" } },
      },
    },
  },
  formatters = {
    file = {
      filename_first = true,
      truncate = 80,
    },
  },
  layout = { hidden = { "preview" }, fullscreen = false },
  ui_select = true,
}

local show_git           = function()
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

local dashboard_keys     = {
  { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
  { icon = " ", key = "F", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
  { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
  { icon = " ", key = "o", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
  { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
  { icon = " ", key = "s", desc = "Restore Session", section = "session" },
  { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
  { icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
        keys = dashboard_keys,
      }
    },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },
    bigfile = { enabled = true },
    notifier = { enabled = true },
    rename = { enabled = true },
    image = { enabled = true },
    picker = picker_config,
    gh = { enabled = true },
  },
  keys = {
    { "gs",         function() require 'snacks'.lazygit.open() end,          desc = "Lazygit" },
    { "<space>gho", function() Snacks.picker.gh_pr() end,                    desc = "GitHub Open PRs" },
    { "<space>ghO", function() Snacks.picker.gh_pr({ state = "all" }) end,   desc = "GitHub All PRs" },
    { "<space>nh",  function() require 'snacks'.notifier.show_history() end, desc = "Notification history" },
    { "<space>gl",  function() Snacks.picker.git_log_line() end,             desc = "Line Commits" },
    { "<space>gL",  function() Snacks.picker.git_log_file() end,             desc = "Buffer Commits" },
    { "<space>gb",  function() Snacks.picker.git_branches() end,             desc = "Git Branches" },
    { "<c-p>",      function() Snacks.picker.files() end,                    desc = "Files" },
    { "<M-p>",      function() Snacks.picker.smart() end,                    desc = "Smart" },
    { "<c-e>",      function() Snacks.picker.buffers() end,                  desc = "Buffers" },
    { "<space>tf",  function() Snacks.picker.grep() end,                     desc = "Grep" },
    { "<space>tF",  function() Snacks.picker.grep_word() end,                desc = "Grep selection or word", mode = { "n", "x" } },
    { "<space>to",  function() Snacks.picker.recent() end,                   desc = "Recent Files" },
    { "<space>tq",  function() Snacks.picker.qflist() end,                   desc = "Quickfix List" },
    { "<space>tl",  function() Snacks.picker.resume() end,                   desc = "Resume" },
    { "<space>tc",  function() Snacks.picker.commands() end,                 desc = "Commands" },
    { "<space>tC",  function() Snacks.picker.command_history() end,          desc = "Command history" },
    { "<space>th",  function() Snacks.picker.help() end,                     desc = "Help tags" },
    { "<space>tm",  function() Snacks.picker.marks() end,                    desc = "Marks" },
    { "<space>tj",  function() Snacks.picker.jumps() end,                    desc = "Jumps" },
    ---@diagnostic disable-next-line: undefined-field
    { "<space>tu",  function() Snacks.picker.undo() end,                     desc = "Undo" },
    { "<space>tr",  function() Snacks.picker.registers() end,                desc = "Registers" },
    { "<space>tb",  function() Snacks.picker.lines() end,                    desc = "Buffer lines" },
    -- { "<space>lm",  function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
    { "<space>lD",  function() Snacks.picker.diagnostics() end,              desc = "Snacks Diagnostics" },
    { "<space>lR",  function() Snacks.picker.lsp_references() end,           nowait = true,                   desc = "References" },
    { "<space>lI",  function() Snacks.picker.lsp_implementations() end,      desc = "Goto Implementation" },
    { "<space>ly",  function() Snacks.picker.lsp_type_definitions() end,     desc = "Goto T[y]pe Definition" },
    { "<space>lw",  function() Snacks.picker.lsp_symbols() end,              desc = "LSP Symbols" },
    {
      "<leader>2",
      function() Snacks.picker.files { dirs = conf_dirs } end,
      desc = "Open Config files"
    },
    {
      "<leader>4",
      function() Snacks.picker.files { dirs = { plugins_dir } } end,
      desc = "Open Plugin files"
    },
    {
      "<leader>5",
      function() Snacks.picker.grep { dirs = { plugins_dir } } end,
      desc = "Grep Plugin files"
    },
    {
      "<leader>3",
      function() Snacks.picker.grep { dirs = conf_dirs } end,
      desc = "Grep config"
    },
  }
}
