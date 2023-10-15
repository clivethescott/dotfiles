return {
  {
    "folke/todo-comments.nvim",
    cmd = { 'TodoTelescope', 'TodoTrouble' },
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    keys = { 'gc', 'gcc', 'gb' },
    config = function()
      require 'Comment'.setup({})
      local ft = require('Comment.ft')

      -- set line and block comment string
      ft.sbt = { '//%s', '/*%s*/' }
      ft.lua = { '--%s', '/*%s*/' }
    end
  }
}
