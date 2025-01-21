return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = 'Neotree',
  opts = {
    filesystem = {
      group_empty_dirs = true,
    },
    buffers = {
      group_empty_dirs = true,
    },
    window = {
      mappings = {
        ["<M-i>"] = {
          "toggle_preview",
        },
      }
    }
  }
}
