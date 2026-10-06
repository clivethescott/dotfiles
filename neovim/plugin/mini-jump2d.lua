vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function()
    vim.pack.add({ { src = 'https://github.com/nvim-mini/mini.jump2d' } })
    require('mini.jump2d').setup {
      view = {
        dim = false,
      },
      allowed_lines = {
        blank = false,
        fold = false,
      },
      mappings = {
        start_jumping = '<CR>',
      },
      silent = true,
    }
  end
})
