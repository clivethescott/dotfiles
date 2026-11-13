vim.pack.add({ { src = 'https://github.com/esmuellert/codediff.nvim' } })

require('codediff').setup{
    diff = { layout = "inline" },
}

vim.keymap.set('n', '<space>gg', '<cmd>CodeDiff<cr>', { desc = 'CodeDiff' })
vim.keymap.set('n', '<space>gq', '<cmd>tabclose<cr>', { desc = 'Close CodeDiff' })
vim.keymap.set('n', '<space>gs', '<cmd>CodeDiff origin/main HEAD<cr>', { desc = 'CodeDiff branch' })
vim.keymap.set('n', '<space>gw', function()
  local diff = require('codediff.config').options.diff
  diff.ignore_trim_whitespace = not diff.ignore_trim_whitespace
  local view = require('codediff.ui.view')
  -- Toggling layout is the only public recompute; twice returns to the original layout.
  view.toggle_layout()
  view.toggle_layout()
  vim.notify('Codediff ignore whitespace: ' .. tostring(diff.ignore_trim_whitespace))
end, { desc = 'CodeDiff toggle ignore whitespace' })
