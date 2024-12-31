return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require 'which-key'
    wk.setup {
      plugins = {
        presets = {
          operators = false,
          motions = false,
        },
      },
    }

    wk.add({
      { "<space>g",  group = "Git" },
      { "<space>n",  group = "Obsidian" },
      { "<space>o",  group = "Open" },
      { "<space>l",  group = "LSP" },
      { "<space>s",  group = "Snacks" },
      { "<space>st", group = "Toggle" },
      { "<space>t",  group = "FZF" },
    })
  end
}
