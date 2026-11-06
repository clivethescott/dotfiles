if not vim.g.is_work_pc then return end

vim.schedule(function()
  vim.pack.add({
    { src = 'https://github.com/selimacerbas/kitehost.nvim' },
    { src = 'https://github.com/selimacerbas/mdkite.nvim' },
  })

  require('mdkite').setup({
    mermaid_renderer = 'rust', -- mmdr from ~/.cargo/bin
  })
end)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(ev)
    vim.keymap.set('n', '<space>mo', '<cmd>MdKite toggle<cr>',
      { buffer = ev.buf, desc = 'Toggle markdown preview' })
    vim.keymap.set('n', '<space>ms', '<cmd>MdKite stop<cr>',
      { buffer = ev.buf, desc = 'Stop markdown preview' })
  end,
})
