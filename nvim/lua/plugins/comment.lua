return {
  {
    "folke/todo-comments.nvim",
    cmd = { 'TodoTelescope', 'TodoTrouble' },
    keys = { '<space>tt', '<space>et' },
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require 'Comment'.setup {
        mappings = {
          -- disable mappings like `gco`, `gcO`, `gcA`
          extra = false,
        },
      }
      local ft = require('Comment.ft')

      -- set line and block comment string
      ft.sbt = { '//%s', '/*%s*/' }
      ft.lua = { '--%s', '/*%s*/' }
    end
  }
}
