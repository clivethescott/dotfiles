return {
  "which-key.nvim",
  event = "DeferredUIEnter",
  after = function()
    local wk = require 'which-key'
    wk.setup {
      present = 'modern',
      delay   = 500,
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
      { "<space>o",  group = "Open" },
      { "<space>l",  group = "LSP" },
      { "<space>lD", group = "LSP Diagnostics" },
      { "<space>t",  group = "FZF" },
      { "<space>a",  group = "AI" },
    })
  end
}
