vim.o.syntax = 'on'

vim.o.dictionary = vim.o.dictionary .. '/usr/share/dict/words'
vim.o.clipboard = 'unnamedplus'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.showmatch = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.hidden = true
vim.o.undodir = '/home/clive/.config/nvim/undodir'
vim.o.splitbelow = true
vim.o.splitright = true
-- Don't pass messages to |ins-completion-menu|.
vim.o.shortmess = vim.o.shortmess .. 'c'
-- Shorter delays and better user experience.
vim.o.updatetime = 100
vim.o.wildignore = vim.o.wildignore .. '*/tmp/*,*.so,*.swp,*.zip,*.jar,*/node_modules/*,*/target/*,*/.git/' ..
'*,*.class,*.pyc,*/plugged/*,*/undodir/*,*.png,*.dex'
vim.o.grepprg = 'rg --vimgrep'
-- Save on make
vim.o.autowrite = true
vim.o.smarttab = true
vim.o.termguicolors = true
-- Also controls which-key delay
vim.o.timeoutlen = 500

vim.wo.cursorline = true
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.wo.signcolumn = 'yes'
vim.wo.colorcolumn = '120'
vim.wo.number = true
vim.wo.relativenumber = true

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.bo.smartindent = true
vim.bo.swapfile = false
vim.bo.undofile = true

-- TODO: figure out why lua config is not being set
vim.cmd[[set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent noswapfile]]
-- Stop newline continution of comments, TODO: convert to lua
-- vim.o.formatoptions-=cro 

-- Nvim config
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_ruby_provider = 0
