return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  opts = {
    delete_to_trash = true,
    default_file_explorer = true, -- allow usage of netrw or not
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = true,
    keymaps = {
      ["<C-i>"] = "actions.preview",
    },
    view_options = {
      show_hidden = false,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<leader>1', '<cmd>Oil<cr>', desc='Oil' },
  }
}
