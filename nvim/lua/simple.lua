-- Use , as leader, define as early as possible
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.opt.dictionary:append('/usr/share/dict/words')
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = vim.env.HOME .. '/.config/nvim/undodir'
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '120'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*.jar', '*/node_modules/*', '*/target/*',
  '*/.git/*', '*.class', '*.pyc', '*/plugged/*', '*/undodir/*', '*.png', '*.dex' })
vim.opt.grepprg = 'rg --vimgrep'

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'neovim/nvim-lspconfig'
  use 'tpope/vim-vinegar'
end)

vim.g.tokyonight_style = "night"
vim.cmd [[colorscheme tokyonight]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      timeout = 500 -- time in ms before highlight is cleared
    }
  end,
  group = highlight_group,
  pattern = '*',
})
-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })

vim.api.nvim_set_hl(0, 'LineNr', { fg = '#737aa2'})

  -- More contrast for Line numbers when using tokyonight
if vim.g.colors_name == 'tokyonight' then
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#737aa2'})
end
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

vim.keymap.set('n', '<leader>m', ':silent! nohls<cr>')
vim.keymap.set('n', '<leader><leader>', ':b#<cr>')
vim.keymap.set('n', '<c-s>', ':w<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:w<cr>')
vim.keymap.set('n', 'Q', ':q<cr>')
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.api.nvim_set_keymap('n', '<space>[', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", { noremap = true })
vim.api.nvim_set_keymap('n', '<space>]', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', { noremap = true })

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
  local caps = client.server_capabilities
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if caps.documentFormattingProvider == true then
    vim.keymap.set('n', 'gq', function() vim.lsp.buf.format { async = true } end, {})
  end

  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)

end
-- https://zignar.net/2022/10/01/new-lsp-features-in-neovim-08/
require'lspconfig'.gopls.setup{
  on_attach = on_attach
}

require('nvim-treesitter.configs').setup{
  highlight = { enable = true },
  indent = { enable = true }
} 
