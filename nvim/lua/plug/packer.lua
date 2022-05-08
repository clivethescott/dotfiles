-- Install packer if not already installed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Reload init.lua on change
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

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

  -- LSP Progress
  use 'arkav/lualine-lsp-progress'

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
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- use 'nvim-treesitter/playground'

  -- LSP Completion
  use 'neovim/nvim-lspconfig'
  use { 'hrsh7th/nvim-cmp',
    requires = {

      -- cmp completion sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-calc'
    }
  }

  -- Additional e.g diagnostics, formatting LSP servers don't provide
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Show me the trouble!
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- snippets
  use 'saadparwaiz1/cmp_luasnip' -- cmp Luasnip completion source
  use 'L3MON4D3/LuaSnip' -- Snippets engine
  use 'rafamadriz/friendly-snippets' -- Collection of Vscode-like Snippets
  use 'honza/vim-snippets' -- Collection of Snipmate-like Snippets

  -- Metals LSP for Scala
  use { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }

  -- Debugger
  use 'mfussenegger/nvim-dap'
  use { 'theHamsta/nvim-dap-virtual-text', requires = { 'mfussenegger/nvim-dap' } }

  -- Floating term
  use 'akinsho/toggleterm.nvim'

  use 'windwp/nvim-autopairs'

  -- keep function name pinned when scrolling
  -- use 'romgrk/nvim-treesitter-context'

  -- Auto close and rename HTML tag
  -- use 'windwp/nvim-ts-autotag'

  -- Distraction Free coding
  use { 'folke/zen-mode.nvim', requires = { 'folke/twilight.nvim' } }

  -- LSP Pictograms
  use 'onsails/lspkind.nvim'

  -- Smooth scrolling
  -- use 'karb94/neoscroll.nvim'
end)
