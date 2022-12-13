-- Install packer if not already installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

-- Reload init.lua on change
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
  { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
  -- Packer manager manages itself
  use 'wbthomason/packer.nvim'

  -- Navigation
  use { 'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }
  use { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'stevearc/dressing.nvim' } -- alternative vim.ui.select and vim.ui.input

  -- Color Theme
  use 'navarasu/onedark.nvim'
  use 'folke/tokyonight.nvim'
  use { "ellisonleao/gruvbox.nvim" }

  -- Comments
  use 'numToStr/Comment.nvim'

  -- Status Line
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Combine tmux and vim status line, must also update tmux config
  -- use 'vimpostor/vim-tpipeline'

  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Surround Text objects
  -- use 'tpope/vim-surround'
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  -- Syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  -- keep function name pinned when scrolling
  -- use { 'romgrk/nvim-treesitter-context' }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
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
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', requires = 'hrsh7th/nvim-cmp' }

  -- Nicer LSP signature float window
  -- use 'ray-x/lsp_signature.nvim'

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
  -- Java LSP
  use { 'mfussenegger/nvim-jdtls' }

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

  -- Floating term
  use 'akinsho/toggleterm.nvim'

  use 'windwp/nvim-autopairs'

  -- Distraction Free coding
  use { 'folke/zen-mode.nvim', requires = { 'folke/twilight.nvim' } }

  -- Auto close and rename HTML tag
  use { 'windwp/nvim-ts-autotag' }

  -- Fancy notifications
  use { 'rcarriga/nvim-notify' }

  -- Combined split-window/tmux navigation
  -- use 'christoomey/vim-tmux-navigator'

  -- Visualize undo history
  use { 'mbbill/undotree', opt = true }

  use 'jparise/vim-graphql'

  -- Smooth scrolling
  -- use { 'karb94/neoscroll.nvim', opt = true }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
