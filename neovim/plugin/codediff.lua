vim.pack.add({ { src = 'https://github.com/esmuellert/codediff.nvim' } })

require('codediff').setup{
    diff = { layout = "inline" },
}

vim.keymap.set('n', '<space>gg', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff' })
vim.keymap.set('n', '<space>gq', '<cmd>tabclose<cr>', { desc = 'Close CodeDiff' })
vim.keymap.set('n', '<space>gs', '<cmd>CodeDiff main...HEAD<cr>', { desc = 'CodeDiff branch' })
