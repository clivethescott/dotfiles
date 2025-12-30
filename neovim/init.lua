vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.use_picker = 'fzf-lua'
vim.g.is_work_pc = vim.env.IS_WORK_PC == "true"
vim.g.no_metals = true

-- vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.colorscheme "default"

local rtp_extras = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/rtp")
if vim.loop.fs_stat(rtp_extras) then
  vim.opt.rtp:append(rtp_extras)
end

-- TODO: figure out why no running
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and kind ~= 'delete' then
      --TODO: replace with plenary
      vim.system({ 'cargo build --release' }, { cwd = ev.data.path })
    else
      if name == 'nvim-treesitter' and kind ~= 'delete' then
        vim.cmd('TSUpdate')
      end
    end
  end,
})

-- Make sure you add lz.n first.
vim.pack.add({ 'https://github.com/lumen-oss/lz.n' })

local plugins = {
  'https://github.com/nvim-lua/plenary.nvim',
  -- treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  -- {src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main'},
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-mini/mini.files',
  'https://github.com/Saghen/blink.cmp',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/DrKJeff16/wezterm-types',
  'https://github.com/b0o/schemastore.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/qvalentin/helm-ls.nvim',
  'https://github.com/obsidian-nvim/obsidian.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/mistweaverco/kulala.nvim',
  'https://github.com/saecki/crates.nvim',
  'https://github.com/linrongbin16/gitlinker.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/scalameta/nvim-metals',
  'https://github.com/folke/sidekick.nvim',
}

--- Add the plugins, replacing the built-in `load` function
--- with lz.n's implementation.
vim.pack.add(plugins, { load = require("lz.n").load("deps") })
