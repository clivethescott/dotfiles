vim.cmd([[
  augroup myoptions
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
      " Help Vim recognize *.sbt and *.sc as Scala files
      autocmd BufRead,BufNewFile *.sbt,*.sc set filetype=scala
      autocmd FileType json syntax match Comment +\/\/.\+$+
    augroup END
]])

