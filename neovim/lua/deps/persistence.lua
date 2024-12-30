return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    need = 2,
    branch = true,
  },
  keys = {
    {
      '<space>ss',
      function() require("persistence").load() end,
      desc = 'Load cwd session'
    },
    {
      '<space>sl',
      function() require("persistence").load({ last = true }) end,
      desc = 'Load last session'
    },
    {
      '<space>so',
      function() require("persistence").select() end,
      desc = 'Select session'
    },
  }
}
