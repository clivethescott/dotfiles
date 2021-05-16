local fn = vim.fn
local exec = vim.api.nvim_command

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  exec('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  exec('packadd packer.nvim')
end

vim.cmd('packadd packer.nvim')

local packer = require('packer')
packer.init({
  auto_clean = false,
  git = {
    clone_timeout = 120,
  }
})

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'morhetz/gruvbox'
  -- use 'itchyny/lightline.vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'mhinz/vim-startify'
  use { 'fatih/vim-go',  run = ':GoUpdateBinaries' }
  use 'kevinhwang91/rnvimr'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'Neevash/awesome-flutter-snippets'
  use {
    'dart-lang/dart-vim-plugin',
    opt = true,
    ft = {'dart'}
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'ryanoasis/vim-devicons', opt = true},
  }
  use 'folke/lsp-colors.nvim'
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
    end
  }
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- use 'airblade/vim-gitgutter'
  -- use 'jparise/vim-graphql'
  -- use 'tpope/vim-commentary'
  -- use 'tpope/vim-abolish'
  -- use 'uarun/vim-protobuf'
  -- -- Ranger plugin

end)

