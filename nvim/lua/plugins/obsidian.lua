return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = 'VeryLazy',
  ft = 'markdown',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Obsidian/Disney/Disney",
      },
    },
    log_level = vim.log.levels.WARN,
    note_frontmatter_func = function(note)
      return {}
    end,
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gd"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<space><space>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
  },

}
