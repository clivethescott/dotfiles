return {
  "folke/snacks.nvim",
  event = 'DeferredUIEnter',
  ---@type snacks.Config
  opts = {
    lazygit = {
      enabled = true,
      config = {
        os = {
          editPreset = "nvim-remote",
          -- https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#configuring-file-editing
          -- change to open in current window, instead of new tab
          edit =
          '`begin; if test -z "$NVIM"; nvim -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{filename}}; end; end`',
          editAtLine =
          '`begin; if test -z "$NVIM"; nvim +{{line}} -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{filename}}; nvim --server "$NVIM" --remote-send ":{{line}}<CR>"; end; end`',
        },
      }
    },
    statuscolumn = { enabled = true },
    notifier = { enabled = true },
    rename = { enabled = true },
    image = { enabled = true },
  },
  keys = {
    { "gs",        function() require 'snacks'.lazygit.open() end,          desc = "Lazygit" },
    { "<space>nh", function() require 'snacks'.notifier.show_history() end, desc = "Notification history" },
  }
}
