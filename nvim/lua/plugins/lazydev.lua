return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "/luvit-meta/library", -- see below
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
}
