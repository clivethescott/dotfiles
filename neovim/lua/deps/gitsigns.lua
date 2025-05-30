local on_attach = function()
  local gitsigns = require 'gitsigns'
  -- Navigation
  local next_hunk = function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gitsigns.nav_hunk('next')
    end
  end
  local prev_hunk = function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gitsigns.nav_hunk('prev')
    end
  end
  -- Text object
  vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk)

  vim.keymap.set('n', ']g', next_hunk, { desc = 'Next Hunk' })
  vim.keymap.set('n', '[g', prev_hunk, { desc = 'Prev Hunk' })
  vim.keymap.set('n', '<space>gd', gitsigns.preview_hunk, { desc = 'Show Diff' })

  vim.keymap.set('n', '<space>gu', gitsigns.reset_hunk, { desc = 'Undo Change' })
  vim.keymap.set('v', '<space>gu', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
    { desc = 'Undo Change' })
  vim.keymap.set('n', '<space>gU', gitsigns.reset_buffer, { desc = 'Undo All Changes' })

  vim.keymap.set('n', '<space>gB', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame' })
  vim.keymap.set('n', '<space>gq', function() gitsigns.setqflist('all') end, { desc = 'All changes to quickfix' })
  vim.keymap.set('n', '<space>gQ', gitsigns.setqflist, { desc = 'Buf changes to quickfix' })
end

return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    on_attach = on_attach,
    word_diff = true,
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '?' },
      changedelete = { text = '~' },
    },
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
  }
}
