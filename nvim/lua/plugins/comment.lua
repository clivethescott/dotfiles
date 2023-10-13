return {
	{
  "folke/todo-comments.nvim",
  cmd = { 'TodoTelescope', 'TodoTrouble' },
  config = function()
    require 'todo-comments'.setup {}
  end
  },
  {
	 'numToStr/Comment.nvim',
	 keys = { 'gc', 'gcc', 'gb' },
   config = function()

    require'Comment'.setup({})
    local ft = require('Comment.ft')

    -- set line and block comment string
    ft.sbt = {'//%s', '/*%s*/'}
    ft.lua = {'--%s', '/*%s*/'}
   end
  }
}
