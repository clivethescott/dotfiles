return {
  'sindrets/diffview.nvim',
  cmd = {'DiffviewOpen', 'DiffviewFileHistory'},
  keys = {
    { "<space>gz", '<cmd>DiffviewClose<cr>', desc = "Close Diffview" },
  },
  config = {
    default_args = {
      DiffviewOpen = { "--imply-local" }, -- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md#comparing-all-the-changes
    },
  },

}
