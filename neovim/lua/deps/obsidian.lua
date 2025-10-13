---@diagnostic disable: missing-fields
return {
  'obsidian-nvim/obsidian.nvim',
  ft = 'markdown',
  cmd = 'Obsidian',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "Work",
        path = "~/Documents/Obsidian/Work",
      },
      {
        name = "Notes",
        path = "~/ObsidianNotes",
      },
    },
    legacy_commands = false,
    log_level = vim.log.levels.WARN,
    completion = { blink = true, min_chars = 2 },
    open = {
      func = function(uri)
        vim.ui.open(uri, { cmd = { "open", "-a", "/Applications/Obsidian.app" } })
      end
    },
    picker = {
      name = 'fzf-lua'
    },
    ui = { enable = false }, -- use MeanderingProgrammer/render-markdown.nvim
    daily_notes = {
      folder = 'daily'
    },
  },
  keys = {
    {
      '<space>no',
      '<cmd>Obsidian quick_switch<cr>',
      desc = 'Open/Switch Note'
    },
    {
      '<space>nf',
      '<cmd>Obsidian search<cr>',
      desc = 'Grep Search Note'
    },
    {
      '<space>nO',
      '<cmd>Obsidian open<cr>',
      desc = 'Open Note in Obsidian app'
    },
    {
      '<space>nt',
      '<cmd>Obsidian today<cr>',
      desc = "Open Today's Note"
    },
{
      '<space>nw',
      '<cmd>Obsidian workspace<cr>',
      desc = "Switch workspace"
    }
  }
}
