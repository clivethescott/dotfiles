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
        path = "~/ObsidianNotes",
      },
    },
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
    mappings = {
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
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
