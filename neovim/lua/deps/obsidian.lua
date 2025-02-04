return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = 'VeryLazy',
  ft = 'markdown',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
  },
  opts = {
    completion = {
      nvim_cmp = false,
    },
    picker = {
      name = 'fzf-lua',
    },
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Obsidian/Work",
      },
      {
        name = "notes",
        path = "~/Documents/Obsidian/Notes",
      },
    },
    log_level = vim.log.levels.WARN,
    note_frontmatter_func = function(note)
      return {}
    end,
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
  },
  keys = {
    { '<space>no', '<cmd>ObsidianQuickSwitch<cr>',       desc = 'Open/Switch Note' },
    { '<space>ne', '<cmd>ObsidianNew<cr>',               desc = 'New Note' },
    { '<space>nv', '<cmd>ObsidianFollowLink vsplit<cr>', desc = 'Open Link vsplit' },
    { '<space>ns', '<cmd>ObsidianFollowLink hsplit<cr>', desc = 'Open Link hsplit' },
    { '<space>nf', '<cmd>ObsidianSearch<cr>',            desc = 'Grep Search Note' },
    { '<space>nw', '<cmd>ObsidianWorkspace<cr>',            desc = 'Switch Workspace' },
    -- { '<space>nf', function() require 'utils'.obsidian_search() end, desc = 'Search Note' },
  }
}
