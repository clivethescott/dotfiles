if has('nvim')
    augroup myoptions
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      " autocmd BufEnter * lua require'completion'.on_attach()
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
      " Format on save
      " autocmd BufWritePre *.{js,jsx,ts,tsx,py,dart,go} lua vim.lsp.buf.formatting_sync(nil, 100)
      " Help Vim recognize *.sbt and *.sc as Scala files
      autocmd BufRead,BufNewFile *.sbt,*.sc set filetype=scala 
      autocmd FileType json syntax match Comment +\/\/.\+$+
      autocmd FileType lua set tabstop=2 softtabstop=2 shiftwidth=2
    augroup END
endif
