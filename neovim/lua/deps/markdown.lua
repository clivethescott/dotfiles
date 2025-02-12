local notes_dir = '~/Documents/Obsidian/'
return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- lazy = false, Lazy-loading will cause more time for the previews to load when starting Neovim?
  ft = {'markdown', 'rust'},
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<space>no',
      function() require 'snacks'.picker.files { dirs = { notes_dir } } end,
      desc = 'Open/Switch Note'
    },
    {
      '<space>nf',
      function() require 'snacks'.picker.grep { dirs = { notes_dir } } end,
      desc = 'Grep Search Note'
    },
  },
}
