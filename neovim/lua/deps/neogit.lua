return {
  "NeogitOrg/neogit",
  cmd = { 'Neogit', 'G', 'Git' },
  keys = {
    { '<space>og', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
    { 'gs', '<cmd>Neogit<cr>', desc = 'Open Neogit' }
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    -- "sindrets/diffview.nvim",        -- optional - Diff integration
    "ibhagwan/fzf-lua",
  },
  config = true
}
