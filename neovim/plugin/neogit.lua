vim.schedule(function()
  vim.pack.add({
    { src = 'https://github.com/esmuellert/codediff.nvim' },
    { src = 'https://github.com/NeogitOrg/neogit' },
  })

  require('neogit').setup({
    diff_viewer = 'codediff',
    integrations = { codediff = true, snacks = true },
  })

  vim.keymap.set('n', 'gs', '<cmd>Neogit<cr>', { desc = 'Neogit' })
end)
