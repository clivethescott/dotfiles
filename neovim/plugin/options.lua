-- Always use the clipboard directly (instead of +/* registers)
-- vim.opt.clipboard = 'unnamedplus'
vim.opt.dictionary:append('/usr/share/dict/words')
vim.opt.spell = true
vim.opt.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.opt.spelllang = 'en_gb'

vim.opt.list = true
vim.opt.listchars = "tab:··,leadmultispace:·"
-- Enables Nicer colors in the terminal
vim.opt.termguicolors = true

vim.opt.lazyredraw = true
-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noinsert,noselect,fuzzy'
vim.o.winborder = 'rounded'

-- Override ignorecase if search includes upper case chars
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Briefly show matching bracket
vim.opt.showmatch = true

-- No need to backup, when we have undo files enabled
vim.opt.backup = false
vim.opt.writebackup = false
---@diagnostic disable-next-line: param-type-mismatch
vim.opt.undodir = vim.fs.joinpath(vim.fn.stdpath('data'), 'undodir')
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
-- vim.opt.grepprg = 'rg --vimgrep --smart-case' -- nvim now auto detects ripgrep!

vim.opt.path:append(vim.fn.stdpath('config'))
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

-- Save on make
vim.opt.autowrite = true

-- Don't wait too long to complete successive keys, Also controls which-key delay
vim.o.timeout = true
vim.opt.timeoutlen = 500

-- Affects redraw speed enable manually
-- vim.opt.cursorcolumn = false
-- vim.opt.cursorline = true
-- vim.opt.colorcolumn = '100'

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = 'yes'

-- autowrap long lines
-- vim.opt.wrap = false
-- vim.opt.linebreak = true
-- vim.opt.textwidth = 100
-- vim.opt.formatoptions:remove "l"

-- Enable line (relative) numbers
vim.opt.number = true
vim.opt.relativenumber = true

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

-- Disable remote plugins
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.o.winborder = 'rounded'

vim.o.foldenable = true
vim.o.foldlevel = 99
-- vim.opt.foldminlines = 5
vim.o.foldmethod = "expr"
-- vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " ", eob = " " })
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

-- Disable modeline
vim.opt.modeline = true

-- Recommended for https://github.com/rmagatti/auto-session
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.sessionoptions:remove "folds" -- fold errors on session restore

vim.opt.diffopt:append {
  'linematch:50',
  'vertical', -- https://github.com/lewis6991/gitsigns.nvim/issues/724
  'foldcolumn:0',
  'indent-heuristic',
  'algorithm:histogram',
}
vim.opt.inccommand = "split"
vim.opt.scrolloff = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.tmux_navigator_no_mappings = 1

vim.opt.conceallevel = 1

vim.opt.formatoptions:remove "o"
vim.opt.showmode = false
vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
vim.g.sidekick_nes = false
