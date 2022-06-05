-- Always use the clipboard directly (instead of +/* registers)
-- vim.opt.clipboard = 'unnamedplus'
vim.opt.dictionary:append('/usr/share/dict/words')

-- Enables Nicer colors in the terminal
vim.opt.termguicolors = true

vim.opt.lazyredraw = true

-- Configure and enable onedark theme
--[[ local onedarkTheme = require('onedark')
onedarkTheme.setup {
  style = 'darker' -- or dark(er), cool, deep, warm(er)
}
onedarkTheme.load() ]]


vim.g.tokyonight_style = "night"
vim.cmd [[colorscheme tokyonight]]

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- Override ignorecase if search includes uppe case chars
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Briefly show matching bracket
vim.opt.showmatch = true

-- No need to backup, when we have undo files enabled
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = vim.env.HOME .. '/.config/nvim/undodir'
vim.opt.undofile = true
vim.opt.swapfile = false
-- Show listchars
-- vim.opt.list = true
-- vim.opt.listchars = {eol = '↵'}

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
vim.opt.grepprg = 'rg --vimgrep'

-- Save on make
vim.opt.autowrite = true

-- Don't wait too long to complete successive keys, Also controls which-key delay
vim.opt.timeoutlen = 1000

-- Affects redraw speed
vim.opt.cursorline = true

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '120'

-- Enable line (relative) numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- See messages better, also avoids hit enter
vim.opt.cmdheight = 1

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

-- Nvim config
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/opt/homebrew/opt/python@3.10/bin/python3'
vim.g.loaded_ruby_provider = 0

vim.opt.foldmethod = 'syntax'
vim.opt.foldminlines = 99
vim.opt.foldlevel = 1

-- Show Lines before/after cursor
vim.opt.scrolloff = 2

