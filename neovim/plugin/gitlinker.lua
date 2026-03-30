vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/linrongbin16/gitlinker.nvim' } })

  require 'gitlinker'.setup {
    router = {
      browse = {
        ["^github%.bamtech%.co"] = require('gitlinker.routers').github_browse,
        ["^github%.twdcgrid%.net"] = require('gitlinker.routers').github_browse,
        ["^github%.prod%.hulu%.com"] = require('gitlinker.routers').github_browse,
      }
    }
  }

  vim.keymap.set({ "n", "v" }, "<space>gy", "<cmd>GitLink<cr>",  { desc = "Yank git link" })
  vim.keymap.set({ "n", "v" }, "<space>gY", "<cmd>GitLink!<cr>", { desc = "Open git link" })
end)
