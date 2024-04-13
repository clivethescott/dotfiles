return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  opts = {
    delete_to_trash = true,
    default_file_explorer = false, -- allow usage of netrw
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-i>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-q>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      -- ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["gh"] = "actions.toggle_hidden",
      ["-"] = "actions.parent",
      ["~"] = "actions.open_cwd",
      [">"] = "actions.cd",
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
