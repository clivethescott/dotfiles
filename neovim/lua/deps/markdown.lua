local notes_dir = '~/Documents/Obsidian/'
return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- lazy = false, Lazy-loading will cause more time for the previews to load when starting Neovim?
  ft = {'markdown', 'rust'},
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = {
      disable_background = {'diff', 'rust'},
    }
  },
  keys = {
    {
      '<space>no',
      function() require 'fzf-lua'.files { cwd = notes_dir } end,
      desc = 'Open/Switch Note'
    },
    {
      '<space>nf',
      function() require 'fzf-lua'.live_grep_glob { cwd = notes_dir } end,
      desc = 'Grep Search Note'
    },
  },
}
