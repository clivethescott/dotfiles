vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.use_picker = 'fzf-lua'
vim.g.is_work_pc = vim.env.IS_WORK_PC == "true"
vim.g.no_metals = true

local rtp_extras = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/rtp")
if vim.loop.fs_stat(rtp_extras) then
  vim.opt.rtp:append(rtp_extras)
end
local install_wait_time_millis = 10000
-- TODO: figure out why no running
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and kind ~= 'delete' then
      --TODO: replace with plenary
      local res = vim.system({ 'cargo build --release' },
        { cwd = ev.data.path }):wait(install_wait_time_millis)
      if vim.v.shell_error ~= 0 then
        vim.notify('failed to compile blink.cmp:' .. res, vim.log.levels.ERROR)
      else
        vim.notify('blink successfully compiled', vim.log.levels.INFO)
      end
    else
      if name == 'nvim-treesitter' and kind ~= 'delete' then
      -- when changing between neovim head/stable
      -- see weird issues where new parsers don't install until old ones are removed
        vim.cmd('TSUnintall all | TSUpdate')
      end
    end
  end,
})

-- Make sure you add lz.n first.
vim.pack.add({ 'https://github.com/lumen-oss/lz.n' })

---Returns a Github vim.pack plugin spec
---@param short_name string
---@param version string?
---@return vim.pack.Spec
local gh = function(short_name, version)
  return {
    src = 'https://github.com/' .. short_name,
    version = version or vim.version.range '*' -- default to stable
  }
end

local plugins = {
  -- {src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main'},
  gh('nvim-treesitter/nvim-treesitter', 'main'),
  gh('nvim-treesitter/nvim-treesitter-context', 'master'),
  gh('nvim-tree/nvim-web-devicons', 'master'), -- fzf-lua relies on the latest api
  gh('nvim-mini/mini.files'),
  gh('Saghen/blink.cmp'),
  gh('MeanderingProgrammer/render-markdown.nvim'),
  gh('folke/lazydev.nvim'),
  gh('DrKJeff16/wezterm-types'),
  gh('b0o/schemastore.nvim', 'main'),
  gh('mason-org/mason.nvim'),
  gh('neovim/nvim-lspconfig'),
  gh('ibhagwan/fzf-lua'),
  gh('stevearc/conform.nvim'),
  gh('qvalentin/helm-ls.nvim', 'main'),
  gh('obsidian-nvim/obsidian.nvim'),
  gh('j-hui/fidget.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('mistweaverco/kulala.nvim'),
  gh('saecki/crates.nvim'),
  gh('linrongbin16/gitlinker.nvim'),
  gh('sindrets/diffview.nvim', 'main'),
  gh('scalameta/nvim-metals'),
  gh('folke/sidekick.nvim'),
}

--- Add the plugins, replacing the built-in `load` function
--- with lz.n's implementation.
vim.pack.add(plugins, { load = require("lz.n").load("deps") })
