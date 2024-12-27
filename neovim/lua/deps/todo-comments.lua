return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = 'BufReadPost',
  cmd = { 'TodoFzfLua', 'TodoTrouble', 'TodoQuickFix' },
  keys = {
    { ']t', function() require("todo-comments").jump_next() end, 'Next TODO' },
    { '[t', function() require("todo-comments").jump_prev() end, 'Previous TODO' },
  },
  opts = {},
}
