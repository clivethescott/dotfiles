vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.use_picker = 'snacks.picker'
-- vim.g.use_picker = 'fzf-lua'

-- Setup lazy
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup({
  { import = "deps" }
}, {
  defaults = {
    version = '*' -- install the latest stable version of plugins that support Semver.
  },
  lockfile = vim.fs.joinpath(vim.fn.stdpath("config"), "lazy-lock.json"),
  change_detection = {
    notify = false
  },
  rocks = {
    enabled = false,
  },
  checker = {
    enabled = false,
    notify = true,                -- get a notification when new updates are found
    frequency = 60 * 60 * 24 * 7, -- check for updates every week
  },
  performance = {
    disabled_plugins = {
      'gzip', 'netrwPlugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin'
    }
  }
})

vim.cmd.colorscheme "catppuccin-mocha"
vim.keymap.set('n', '<space>ol', '<cmd>Lazy<cr>', { desc = 'Lazy Package Mgr' })


local rtp_extras = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/rtp")
if vim.loop.fs_stat(rtp_extras) then
  vim.opt.rtp:append(rtp_extras)
end
