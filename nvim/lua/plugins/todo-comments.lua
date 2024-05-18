return {
  "folke/todo-comments.nvim",
  event = 'BufReadPost',
  cmd = { 'TodoTelescope', 'TodoTrouble' },
  keys = { '<space>tt', '<space>et' },
  opts = {},
}
