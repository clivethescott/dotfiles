local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

nvim_tree.setup { -- BEGIN_DEFAULT_OPTS
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  respect_buf_cwd = true,
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
  },
  filters = {
    dotfiles = false,
    custom = { '.git', '.DS_Store', 'target', '.bloop', '.bsp', '.metals' },
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  trash = {
    cmd = 'trash', -- for macos using https://gist.github.com/dabrahams/14fedc316441c350b382528ea64bc09c
    require_confirm = false,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = true,
    },
  },
}
