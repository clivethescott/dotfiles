if has('nvim')
    augroup myoptions
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      " autocmd BufEnter * lua require'completion'.on_attach()
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
      " autocmd BufRead,BufNewFile *.dart set foldmethod=syntax
      " autocmd BufRead,BufNewFile *.go set foldmethod=indent
      " Format on save
      " autocmd BufWritePre *.{js,jsx,ts,tsx,py,dart,go} lua vim.lsp.buf.formatting_sync(nil, 100)
      " Help Vim recognize *.sbt and *.sc as Scala files
      autocmd BufRead,BufNewFile *.sbt,*.sc set filetype=scala 
      autocmd FileType json syntax match Comment +\/\/.\+$+
      autocmd BufNewFile *.sh silent! 0r ~/.config/nvim/templates/skel.sh
      autocmd BufNewFile *.dart silent! 0r ~/.config/nvim/templates/skel.dart
    augroup END
endif
