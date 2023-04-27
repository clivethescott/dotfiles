local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

local api = require 'nvim-tree.api'

local SORT_METHODS = {
  "name",
  "case_sensitive",
  "modification_time",
  "extension",
}
local sort_current = 1

local cycle_sort = function()
  if sort_current >= #SORT_METHODS then
    sort_current = 1
  else
    sort_current = sort_current + 1
  end
  api.tree.reload()
end

local sort_by = function()
  return SORT_METHODS[sort_current]
end

nvim_tree.setup { -- BEGIN_DEFAULT_OPTS
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  respect_buf_cwd = true,
  live_filter = {
    always_show_folders = false, -- Turn into false from true by default
  },
  sort_by = sort_by,
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

vim.keymap.set('n', 'T', cycle_sort, {desc = 'Cycle Sort'})

-- auto open files upon creation
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)
