return {
  "nvim-telescope/telescope-frecency.nvim",
  keys = '<space>t',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require("telescope").load_extension "frecency"
  end,
}
