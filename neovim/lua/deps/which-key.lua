return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require 'which-key'
    wk.setup {
      plugins = {
        presets = {
          operators = true,
          motions = true,
        },
      },
    }

    wk.add({
      { "<space>f",  group = "Files" },
      { "<space>g",  group = "Git" },
      { "<space>h",  group = "HTTP" },
      { "<space>s",  group = "Sessions" },
      { "<space>n",  group = "Obsidian" },
      { "<space>nt", desc = "Toggle checkbox" },
      { "<space>na", desc = "Smart action" },
      { "<space>o",  group = "Open" },
      { "<space>l",  group = "LSP" },
      { "<space>lD", group = "LSP Diagnostics" },
      { "<space>t",  group = "FZF" },
    })
  end
}
