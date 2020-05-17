au FileType python BufNewFile,BufRead
    \ match BadWhitespace /\s\+$/
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal autoindent
setlocal fileformat=unix
let b:ctrlp_user_command = 'rg %s --files --type python'
