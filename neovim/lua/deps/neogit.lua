return {
  "NeogitOrg/neogit",
  cmd = { 'Neogit', 'G', 'Git' },
  keys = {
    { '<space>og', '<cmd>Neogit<cr>', desc = 'Open Neogit' }
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    -- "sindrets/diffview.nvim",        -- optional - Diff integration
    -- Only one of these is needed, not both.
    "ibhagwan/fzf-lua",
  },
  config = true
}
