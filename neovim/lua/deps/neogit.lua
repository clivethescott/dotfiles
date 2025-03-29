return {
  "NeogitOrg/neogit",
  cmd = { 'Neogit', 'G', 'Git' },
  keys = { '<space>og', 'gs' },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua"
  },
  config = true,
  keys = {
    {
      "gs",
      "<cmd>Neogit<cr>",
      desc = "Neogit"
    }
  }
}
