local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
  { import = "plugins" }
}, {
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
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
