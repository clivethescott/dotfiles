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
  vim.keymap.set('n', 'i', cycle_sort, opts('Change Sort'))

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
      live_filter = {                -- show dirs
        prefix = "[FILTER]: ",
        always_show_folders = false, -- Turn into false from true by default
      }
    })
  end
}
