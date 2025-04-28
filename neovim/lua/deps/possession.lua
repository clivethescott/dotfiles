return {
  "gennaro-tedesco/nvim-possession",
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  config = function()
    require 'nvim-possession'.setup {
      fzf_winopts = {
        width = 0.9,
        height = 0.9,
        preview = {
          -- vertical = "right:50%",
          default = 'bat',
        }
      },
      sort = require("nvim-possession.sorting").time_sort,
    }
  end,
  keys = {
    { "<space>sl", function() require("nvim-possession").list() end,   desc = "List sessions", },
    { "<space>sn", function() require("nvim-possession").new() end,    desc = "Create session", },
    { "<space>su", function() require("nvim-possession").update() end, desc = "Update current session", },
    { "<space>sd", function() require("nvim-possession").delete() end, desc = "Delete selected session" },
  },
}
