nnoremap <buffer> <leader>l :DartFmt<CR>
nnoremap <buffer> <leader>d :g#^\s*//.*#d<CR>:DartFmt<CR>
let b:ctrlp_user_command = 'rg %s --files --type flutter'
setlocal tabstop=2 softtabstop=2
setlocal shiftwidth=2
" Match braces
" inoremap <buffer> { {<CR>}<Esc>ko

