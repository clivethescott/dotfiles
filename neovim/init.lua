-- Lua annotations https://github.com/LuaLS/lua-language-server/wiki/Annotations
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.use_picker = 'fzf-lua'
vim.g.is_work_pc = vim.env.IS_WORK_PC == "true"
vim.g.no_metals = true

local rtp_extras = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/rtp")
if vim.loop.fs_stat(rtp_extras) then
  vim.opt.rtp:append(rtp_extras)
end

-- Make sure you add lz.n first.
vim.pack.add({ 'https://github.com/lumen-oss/lz.n' })

---@class LazyOpts
---@field ft string[]|string?
---@field branch string?
---@field version string?

---Returns a Github vim.pack plugin spec
---@param opts LazyOpts?
---@return vim.pack.Spec
local gh = function(short_name, opts)
  opts = opts or {}
  local spec = {
    src = 'https://github.com/' .. short_name,
    version = opts.branch or opts.version or vim.version.range '*' -- default to stable
  }
  if opts.ft then
    spec.data = {}
    spec.data.ft = opts.ft
  end
  return spec
end

local plugins = {
  gh('nvim-treesitter/nvim-treesitter', { branch = 'main' }),
  gh('nvim-treesitter/nvim-treesitter-context', { branch = 'master' }),
  gh('nvim-treesitter/nvim-treesitter-textobjects', { branch = 'main' }),
  gh('nvim-tree/nvim-web-devicons', { branch = 'master' }),
  gh('nvim-mini/mini.files'),
  gh('Saghen/blink.cmp'),
  gh('MeanderingProgrammer/render-markdown.nvim'),
  gh('folke/lazydev.nvim'),
  gh('DrKJeff16/wezterm-types'),
  gh('b0o/schemastore.nvim', { branch = 'main' }),
  gh('mason-org/mason.nvim'),
  gh('neovim/nvim-lspconfig'),
  gh('ibhagwan/fzf-lua'),
  gh('stevearc/conform.nvim'),
  gh('qvalentin/helm-ls.nvim', { branch = 'main', ft = { 'yaml', 'helm' } }),
  gh('obsidian-nvim/obsidian.nvim'),
  gh('j-hui/fidget.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('mistweaverco/kulala.nvim'),
  gh('saecki/crates.nvim'),
  gh('linrongbin16/gitlinker.nvim'),
  gh('sindrets/diffview.nvim', { branch = 'main' }),
  gh('scalameta/nvim-metals'),
  gh('folke/sidekick.nvim'),
}

--- Add the plugins, replacing the built-in `load` function
--- with lz.n's implementation.
vim.pack.add(plugins, { load = require("lz.n").load("deps") })

vim.keymap.set('n', '<space>ol', function()
  vim.pack.update(nil, { force = false })
end)
