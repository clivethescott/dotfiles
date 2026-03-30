return {
  "folke/persistence.nvim",
  cond = vim.g.is_work_pc,
  config = true,
  keys = {
    { "<space>sl", function() require("persistencee").load() end,   desc = "Load cwd session", },
    { "<space>sL", function() require("persistencee").load({last=true}) end,   desc = "Load last session", },
    { "<space>ss", function() require("persistence").select() end,    desc = "Select a session", },
    { "<space>sd", function() require("persistency").stop() end, desc = "Stop session" },
    { "<space>sq", function() require("persistency").stop() end, desc = "Stop session" },
  },
}
