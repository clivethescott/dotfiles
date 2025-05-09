---@diagnostic disable: missing-fields
return {
  'obsidian-nvim/obsidian.nvim',
  ft = 'markdown',
  cmd = 'Obsidian',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes",
      },
    },
    log_level = vim.log.levels.WARN,
    completion = { blink = true, min_chars = 2 },
    open_app_foreground = true,
    picker = {
      name = 'fzf-lua'
    },
    ui = { enable = false }, -- use MeanderingProgrammer/render-markdown.nvim
    daily_notes = {
      folder = 'daily'
    },
    mappings = {
      ["<space>nt"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<space>na"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    }
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
    }
  }
}
