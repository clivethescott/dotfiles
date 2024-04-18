return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = {
      -- Set to false to disable the vim.ui.input implementation
      enabled = true,

      border = "rounded",
      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      prefer_width = 50,
      width = nil,
      -- min_width and max_width can be a list of mixed types.
      -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
      max_width = { 140, 0.9 },
      min_width = { 40, 0.4 },
      -- IncRename Tip - try these `dressing.nvim` settings to position the input box above the
      -- > cursor to not cover the word being renamed
      override = function(conf)
        conf.col = -1
        conf.row = 0
        return conf
      end

    },
    select = {
      -- Set to false to disable the vim.ui.select implementation
      enabled = true,

      -- Priority list of preferred vim.select implementations
      backend = { "telescope", "builtin" },

      -- Options for telescope selector
      -- These are passed into the telescope picker directly. Can be used like:
      -- telescope = require('telescope.themes').get_ivy({...})
      telescope = nil,

      -- Used to override format_item. See :help dressing-format
      format_item_override = {},

      -- see :help dressing_get_config
      get_config = nil,
    },
  }
}
