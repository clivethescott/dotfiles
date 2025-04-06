return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "ibhagwan/fzf-lua",       -- optional
  },
  config = true,
  event = 'VeryLazy',

  keys = {
    { "<space>gc", function() require 'neogit'.open({ 'commit' }) end, desc = "Neogit Commit" },
    { "<space>go", function() require 'neogit'.open() end, desc = "Open Neogit" },
  },
}
