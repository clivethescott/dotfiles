vim.cmd([[colorscheme gruvbox]])
-- highlight color, set after colorscheme
-- Enable transparency
vim.cmd('au BufRead,BufNewFile * hi Normal guibg=NONE ctermbg=NONE')
-- Visual indication of yanked text
vim.cmd([[hi HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A]])
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = true}'
-- LSP colors
-- vim.cmd 'au BufRead,BufNewFile * hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,underline'
-- vim.cmd 'au BufRead,BufNewFile * hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,underline'
-- vim.cmd 'au BufRead,BufNewFile * hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline'
-- vim.cmd 'au BufRead,BufNewFile * hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline'


