" Script to restore last known cursor position
" Last Change: Sat 06 Jun 2020 22:49:48 GMT+2
" Maintainer: clivethescott@gmail.com

if exists('loaded_restore_cursor')
    finish
endif
let loaded_restore_cursor = 1

function RestoreCursorPosition()
if &filetype != 'gitcommit'
    execute "normal g`\""
endif
endfunction
