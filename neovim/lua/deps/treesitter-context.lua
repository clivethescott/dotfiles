return {
  'nvim-treesitter-context',
  keys = {
    { '[h', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'Jump to TS context' },
    { ']h', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'Jump to TS context' },
  },
  after = function()
    require('treesitter-context').setup({
      multiline_threshold = 999,
      -- separator = '-',
      max_lines = 1,
    })
  end,
}
