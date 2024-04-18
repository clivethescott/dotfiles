-- Always use the clipboard directly (instead of +/* registers)
local nvim_config_dir = vim.fn.stdpath('config')
local nvim_data_dir = vim.fn.stdpath('data')
vim.opt.clipboard = 'unnamedplus'
vim.opt.dictionary:append('/usr/share/dict/words')
-- vim.opt.spell = true
-- vim.opt.spelllang = 'en_gb'

vim.opt.list = true
vim.opt.listchars = "tab:··,leadmultispace:·"
-- Enables Nicer colors in the terminal
vim.opt.termguicolors = true

vim.opt.lazyredraw = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- Override ignorecase if search includes upper case chars
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = false
vim.opt.hlsearch = true

-- Briefly show matching bracket
vim.opt.showmatch = true

-- No need to backup, when we have undo files enabled
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = nvim_data_dir .. '/undodir'
vim.opt.undofile = true
vim.opt.swapfile = false

-- Sensible split behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Ensure nvim-metals shows error messages
-- Don't pass messages to |ins-completion-menu|.
-- vim.opt.shortmess:remove('F'):append('c'):append('m')

-- Shorter delays and better user experience.
vim.opt.updatetime = 100

vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*.jar', '*/node_modules/*', '*/target/*',
  '*/.git/*', '*.class', '*.pyc', '*/plugged/*', '*/undodir/*', '*.png', '*.dex' })
vim.opt.grepprg = 'rg --vimgrep --smart-case'

vim.opt.path:append(nvim_config_dir)
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

-- Save on make
vim.opt.autowrite = true

-- Don't wait too long to complete successive keys, Also controls which-key delay
-- Disabled - set in whick-key config
vim.opt.timeoutlen = 500

-- Affects redraw speed
-- vim.opt.cursorcolumn = false
vim.opt.cursorline = true

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '100'

-- Enable line (relative) numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cmdheight = 0

-- Don't show mode change messages
vim.opt.showmode = false

-- Number of spaces equal to a tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- Tabs become spaces
vim.opt.expandtab = true
vim.opt.smarttab = true
-- Continue indent on new line
vim.opt.smartindent = true

-- Disable remote plugins
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.foldmethod = 'syntax'
vim.opt.foldminlines = 20
-- vim.opt.foldlevel = 2
-- Disable for now doesn't work properly with gitconfig files
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

-- Disable modeline
vim.opt.modeline = false

-- Recommended for https://github.com/rmagatti/auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.diffopt = "filler,context:0" -- hide the rest
vim.opt.inccommand = "split"

-- mainly to work nicely with nvim-tree, remove if not needed
local disable_netrw = true

if disable_netrw then
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
else
  -- toggle with I
  vim.g.netrw_banner = 0
  -- hide dotfiles
  vim.cmd [[ let g:netrw_list_hide="\.pdf$,\.jpg$,\.git/,\.metals/".netrw_gitignore#Hide() ]]
  -- 50% split size
  vim.g.netrw_winsize = 50
  -- tree style listing
  vim.g.netrw_liststyle = 3
  -- show line numbers
  vim.g.netrw_bufsettings = 'nomodifiable nobuflisted nowrap readonly number relativenumber'
end
