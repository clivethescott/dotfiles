return {
  "NeogitOrg/neogit",
  cmd = {'Neogit', 'G', 'Git'},
  keys = {'<space>og'},
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true
}
