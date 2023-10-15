return {
  'stevearc/oil.nvim',
  keys = '<space>f',
  cmd = 'Oil',
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    trash_command = 'trash',
    use_default_keymaps = false,
    keymaps = {
      ["<CR>"] = "actions.select",
      ["<C-]"] = "actions.select",
      ["-"] = "actions.parent",
      ["$"] = "actions.open_cwd",
      [">"] = "actions.cd",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
