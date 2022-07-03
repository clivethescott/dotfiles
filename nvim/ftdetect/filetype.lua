vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Fix filetype detection of Scala scripts',
  pattern = { '*.sc' },
  callback = function()
    vim.bo.filetype = "scala"
  end,
})

