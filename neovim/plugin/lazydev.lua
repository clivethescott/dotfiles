vim.pack.add({ { src = 'https://github.com/DrKJeff16/wezterm-types' } })
vim.pack.add({ { src = 'https://github.com/folke/lazydev.nvim' } })

require('lazydev').setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    "~/.config/wezterm",
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "Snacks.nvim",        words = { "Snacks" } },
    { path = 'wezterm-types',      mods = { 'wezterm' } },
    -- github.com/neovim/nvim-lspconfig/pull/4306
    { path = 'nvim-lspconfig',     words = { 'lspconfig' } },
  },
})
