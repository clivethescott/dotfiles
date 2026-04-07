vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function()
    vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } })
    vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context', version = 'master' } })

    require('treesitter-context').setup({
      multiline_threshold = 999,
      -- separator = '-',
      max_lines = '20%',
    })

    vim.keymap.set('n', '[h', function() require("treesitter-context").go_to_context(vim.v.count1) end,
      { desc = 'Jump to TS context' })
    vim.keymap.set('n', ']h', function() require("treesitter-context").go_to_context(vim.v.count1) end,
      { desc = 'Jump to TS context' })
  end
})
