return {
  'linrongbin16/gitlinker.nvim',
  cmd = 'GitLink',
  event = 'BufReadPost',
  keys = {
    { "<space>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Yank git link" },
    { "<space>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
  },
  config = function()
    require 'gitlinker'.setup {
      router = {
        browse = {
          ["^github%.bamtech%.co"] = require('gitlinker.routers').github_browse,
          ["^github%.twdcgrid%.net"] = require('gitlinker.routers').github_browse,
        }
      }
    }
  end
}
