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

return packer.startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'morhetz/gruvbox'
  use 'itchyny/lightline.vim'
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
  -- use { 'mbbill/undotree', opt = true cmd = 'UndotreeToggle' }
  -- use { 'junegunn/fzf', run = 'cd ~/.fzf && ./install --all' }
  -- use { 
  --   'dart-lang/dart-vim-plugin', 
  --   opt = true, 
  --   ft = {'dart'}
  -- }
  -- use 'airblade/vim-gitgutter'
  -- use 'jparise/vim-graphql'
  -- use 'tpope/vim-commentary'
  -- use 'tpope/vim-abolish'
  -- use 'uarun/vim-protobuf'
  -- -- Ranger plugin
  -- use { 'kevinhwang91/rnvimr', run = 'make sync' }

end)

