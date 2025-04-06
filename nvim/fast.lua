vim.g.mapleader = ','
vim.g.maplocalleader = ','

local nvim_data_dir = vim.fn.stdpath('data')
vim.opt.clipboard = 'unnamedplus'
vim.opt.dictionary:append('/usr/share/dict/words')
vim.opt.spell = true
vim.opt.spelllang = 'en_gb'

-- Enables Nicer colors in the terminal
vim.opt.termguicolors = true
-- vim.cmd [[ colorscheme habamax ]] -- use the new default theme in Neovim!

vim.opt.lazyredraw = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- Override ignorecase if search includes upper case chars
vim.opt.smartcase = true
vim.opt.ignorecase = true

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

-- Shorter delays and better user experience.
vim.opt.updatetime = 100

vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*.jar', '*/node_modules/*', '*/target/*',
  '*/.git/*', '*.class', '*.pyc', '*/plugged/*', '*/undodir/*', '*.png', '*.dex' })
vim.opt.grepprg = 'rg --vimgrep --smart-case'

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

vim.opt.foldmethod = 'syntax'
vim.opt.foldminlines = 20
-- vim.opt.foldlevel = 2
-- Disable for now doesn't work properly with gitconfig files
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false
vim.opt.modeline = false

-- Recommended for https://github.com/rmagatti/auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.diffopt = "filler,context:0" -- hide the rest
vim.opt.inccommand = "split"

local default_opts = { silent = true, noremap = true }
local map = function(mode, lhs, rhs, opts)
  if opts then
    vim.tbl_extend('keep', opts, default_opts)
  else
    opts = default_opts
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', 'k', [[v:count < 2 ? 'gk' : "m'" .. v:count .. 'k']], { expr = true })
map('n', 'j', [[v:count < 2 ? 'gj' : "m'" .. v:count .. 'j']], { expr = true })

map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Resize v-splits
map('n', '<space>wh', '5<c-w><')
map('n', '<space>wk', '5<c-w>+')
map('n', '<space>wl', '5<c-w>>')
map('n', '<space>wj', '5<c-w>-')

-- Saving
map('n', '<c-s>', ':update<cr>')
map('i', '<c-s>', '<esc>:update<cr>')


map('n', 'Q', ':q<cr>')
map('n', 'Y', 'yy')

-- Keep selection after visual indent/outdent
map('v', '<', '<gv')
map('v', '>', '>gv')


local toggle_winbar = function()
  if vim.o.winbar == "" then
    vim.o.winbar = "%{%v:lua.require'helper.utils'.nvim_winbar()%}"
  else
    vim.o.winbar = ""
  end
end

-- Quickly add empty lines
map('n', '<space>[', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
map('n', '<space>]', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>')
map('n', '<space>of', toggle_winbar)
map('n', 'gp', ":b#<cr>")
map('n', '<space>io', ':Explore<cr>')
map('n', '<space>iO', ':Lexplore %:p:h<cr>')
map('n', '<space>iv', ':Vexplore %:p:h<cr>')

map('n', '<leader>m', ':nohls<cr>')

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'TermCursor',
      timeout = 500 -- time in ms before highlight is cleared
    }
  end,
  group = highlight_group,
  pattern = '*',
})
vim.api.nvim_set_hl(0, 'WinBarPath', { fg = '#545c7e' })
vim.api.nvim_set_hl(0, 'WinBarModified', { fg = '#e0af68' })


vim.api.nvim_create_user_command('FZF', function()
  vim.cmd [[
    let l:tempname = tempname()
    " fzf | awk '{ print $1":1:0" }' > file
    execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
    try
        execute 'cfile ' . l:tempname
        redraw!
    finally
        call delete(l:tempname)
    endtry
  ]]
end, {})


local events_group = vim.api.nvim_create_augroup('CustomEventsGroup', { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  desc = 'Listchars for indentation based languages',
  group = events_group,
  pattern = { '*.py', '*.yaml', '*.yml', '*.sc' },
  callback = function()
    vim.wo.list = true
    vim.wo.listchars = "leadmultispace:·"
  end,
})

local home = os.getenv('HOME')
local global_ignore = home .. '/.gitignore'

-- See :h findfunc
-- Ref https://github.com/adiSuper94/config/blob/189d82910f9a0dcc3e093a5e26b9b944ae0ecbea/nvim/lua/plugins/fuzzysearch.lua#L12-L24
function Fd(file_pattern, _)
  -- if first char is * then fuzzy search
  if file_pattern:sub(1, 1) == "*" then
    file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
  end

  local cmd = { "fd", "--type", "file", "--hidden", "--max-depth", "10", "--strip-cwd-prefix", "--follow",
    "--color=never", "--full-path",
    "--ignore-file", global_ignore, "--exclude=.git",
    '"' .. file_pattern .. '"' }
  return vim.fn.systemlist(table.concat(cmd, " "))
end

vim.opt.findfunc = "v:lua.Fd"
