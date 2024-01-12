local SORT_METHODS = {
  "name",
  "case_sensitive",
  "modification_time",
  "extension",
}
local sort_current = 1

local sort_by = function()
  return SORT_METHODS[sort_current]
end


local on_attach = function(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local cycle_sort = function()
    if sort_current >= #SORT_METHODS then
      sort_current = 1
    else
      sort_current = sort_current + 1
    end
    api.tree.reload()
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'gh', api.tree.toggle_help, opts('Nvim Tree Help'))
  vim.keymap.set("n", "g.", api.tree.toggle_custom_filter, opts "Toggle Hidden")
  vim.keymap.set('n', 'i', cycle_sort, opts('Change Sort'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.set("n", "s", api.node.open.horizontal, opts "Open: Horizontal Split")
  vim.keymap.set("n", "<C-i>", api.node.open.preview, opts "Open Preview")
  vim.keymap.set("n", "[g", api.node.navigate.git.prev, opts "Prev Git")
  vim.keymap.set("n", "]g", api.node.navigate.git.next, opts "Next Git")
  vim.keymap.set("n", "rf", api.fs.rename_basename, opts "Rename: Basename")
  vim.keymap.set("n", "rF", api.fs.rename, opts "Rename: Path")
  vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
  vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
  vim.keymap.set("n", "s", api.tree.search_node, opts "Search")
  vim.keymap.set("n", "yf", api.fs.copy.filename, opts "Copy File Name")
  vim.keymap.set("n", "yF", api.fs.copy.absolute_path, opts "Copy Absolute Path")
  vim.keymap.set("n", "t", api.marks.toggle, opts "Toggle Bookmark")
  vim.keymap.set("n", "q", api.tree.close, opts "Close")
  vim.keymap.set("n", "<esc>", api.tree.close, opts "Close")
  vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
  vim.keymap.set("n", "x", api.node.run.system, opts "Run System")
  vim.keymap.set("n", "C", api.tree.collapse_all, opts "Collapse")
  vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts "CD")

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
end
return {
  "nvim-tree/nvim-tree.lua",
  cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = on_attach,
      sort_by = sort_by,
      filters = { custom = { "^.git$", "^target$" } },
      notify = {
        threshold = vim.log.levels.WARN,
      },
      renderer = {
        group_empty = true,
      },
      view = {
        number = true,
        relativenumber = true,
      },
      live_filter = {                -- show dirs
        prefix = "[FILTER]: ",
        always_show_folders = false, -- Turn into false from true by default
      }
    })
  end
}
