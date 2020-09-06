" Script to change Last Change date modified
" Last Change: Thu 21 May 2020 11:10:33 GMT+2
" Maintainer: clivethescott@gmail.com

if exists('loaded_date_set')
    finish
endif
let loaded_date_set = 1

function UpdateDateModified()
for lineNumber in range(1, 10)
    let line = getline(lineNumber)
    if line =~? 'Last Change: '
        let updatedLine = "\" Last Change: " . strftime("%c") . " GMT+2"
        call setline(lineNumber, updatedLine)
        break
    endif
endfor
endfunction
