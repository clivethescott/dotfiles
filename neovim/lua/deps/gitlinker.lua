return {
  'linrongbin16/gitlinker.nvim',
  cmd = 'GitLink',
  event = 'BufReadPost',
  keys = {
    { "<space>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Yank git link" },
    { "<space>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
  },
  opts = {
    router = {
      browse = {
        ["^github%.bamtech%.co"] = "https://github.bamtech.co/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.REV}/"
            .. "{_A.FILE}?plain=1"   -- '?plain=1'
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        ["^github%.twdcgrid%.net"] = "https://github.twdcgrid.net/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.REV}/"
            .. "{_A.FILE}?plain=1"   -- '?plain=1'
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
      }
    },
  }
}
