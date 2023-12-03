return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = { 'ObsidianToday', 'ObsidianYesterday', 'ObsidianSearch', 'ObsidianWorkspace' },
  keys = { '<space>n' },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Documents/Obsidian/Notes",
      },
    },
    -- see below for full list of options 👇
  },
}
