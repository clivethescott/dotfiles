return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  keys = {
    { "<space>gx", '<cmd>DiffviewClose<cr>', desc = "Close Diffview" },
    { "<space>go", '<cmd>DiffviewOpen<cr>', desc = "Open Diffview" },
    { "<space>gs", '<cmd>DiffviewOpen main...HEAD<cr>', desc = "Diffview branch" },
  },
  opts = {
    default_args = {
      DiffviewOpen = { "--imply-local" }, -- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md#comparing-all-the-changes
    },
  },
}
