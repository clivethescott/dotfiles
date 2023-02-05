-- Install packer if not already installed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Packer manager manages itself
  use 'wbthomason/packer.nvim'

  -- Navigation
  use { 'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'stevearc/dressing.nvim' } -- alternative vim.ui.select and vim.ui.input

  -- Color Theme
  use 'folke/tokyonight.nvim'

  -- Comments
  use 'numToStr/Comment.nvim'

  -- Status Line
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  -- Additional textobjects for treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  -- use 'nvim-treesitter/playground'

  -- keep function name pinned when scrolling
  use { 'romgrk/nvim-treesitter-context' }

  -- LSP
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }
  use 'hrsh7th/nvim-cmp'
  use { 'hrsh7th/cmp-nvim-lsp', requires = 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp-document-symbol', requires = 'hrsh7th/nvim-cmp' }
  -- 'hrsh7th/cmp-nvim-lsp-signature-help'
  use { 'hrsh7th/cmp-nvim-lua', requires = 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-calc', requires = 'hrsh7th/nvim-cmp' }
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }

  -- Nicer LSP signature float window
  use 'ray-x/lsp_signature.nvim'

  -- LSP Progress
  -- use 'arkav/lualine-lsp-progress'
  use { 'j-hui/fidget.nvim',
    config = function() require 'fidget'.setup {} end
  }

  -- LSP Icons in completion
  use 'onsails/lspkind.nvim'

  -- Additional e.g diagnostics, formatting LSP servers don't provide
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Show me the LSP trouble!
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- Metals LSP for Scala
  use { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }

  -- DAP
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use { 'theHamsta/nvim-dap-virtual-text', requires = { 'mfussenegger/nvim-dap' } }
  use { 'leoluz/nvim-dap-go', requires = { 'mfussenegger/nvim-dap' } } -- requires delve
  use { 'nvim-telescope/telescope-dap.nvim', requires = { 'mfussenegger/nvim-dap' } }

  -- snippets
  use 'saadparwaiz1/cmp_luasnip' -- cmp Luasnip completion source
  use 'L3MON4D3/LuaSnip' -- Snippets engine
  use 'rafamadriz/friendly-snippets' -- Collection of Vscode-like Snippets
  -- use 'honza/vim-snippets' -- Collection of Snipmate-like Snippets

  -- Diff previewer
  -- use { 'sindrets/diffview.nvim' }

  -- Floating term
  use 'akinsho/toggleterm.nvim'

  use 'windwp/nvim-autopairs'

  -- Distraction Free coding
  use { 'folke/zen-mode.nvim', requires = { 'folke/twilight.nvim' } }

  -- Auto close and rename HTML tag
  use { 'windwp/nvim-ts-autotag' }

  -- Fancy notifications
  use { 'rcarriga/nvim-notify' }

  use 'chentoast/marks.nvim'

  use 'ggandor/leap.nvim'

  -- Visualize undo history
  use { 'mbbill/undotree', opt = true }

  if is_bootstrap then
    require('packer').sync()
  end

end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
