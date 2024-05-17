return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  opts = {
    delete_to_trash = true,
    default_file_explorer = true, -- allow usage of netrw or not
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<M-v>"] = "actions.select_vsplit",
      ["<M-s>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-i>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<M-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      [">"] = "actions.cd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },
    view_options = {
      show_hidden = false,
      is_always_hidden = function(name, _)
        if string.find(name, 'target') then
          vim.print(name)
        end
        return string.find(name, '.git') or string.find(name, 'target')
      end,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
