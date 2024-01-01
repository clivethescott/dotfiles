return {
  "folke/zen-mode.nvim",
  cmd = { 'ZenMode' },
  dependencies = {
    {
      "folke/twilight.nvim",
      cmd = { 'Twilight' },
    }
  },
  opts = {
    window = {
      options = {
        relativenumber = false,
        number = false,
        cursorline = false,
        list = false,
      }
    },
    plugins = {
      options = {
        laststatus = 0,
      }
    },
    on_close = function()
    end,
  }
}
