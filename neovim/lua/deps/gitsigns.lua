local on_attach = function()
  local gs = package.loaded.gitsigns
  -- Navigation
  local next_hunk = function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end
  local prev_hunk = function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end
  -- Text object
  vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

  vim.keymap.set('n', ']g', next_hunk, { desc = 'Next Hunk' })
  vim.keymap.set('n', '[g', prev_hunk, { desc = 'Prev Hunk' })
  vim.keymap.set('n', '<space>gd', gs.preview_hunk, { desc = 'Show Diff' })
  vim.keymap.set('n', '<space>gu', gs.reset_hunk, { desc = 'Undo Change' })
  vim.keymap.set('n', '<space>gU', gs.reset_buffer, { desc = 'Undo All Changes' })
  vim.keymap.set('n', '<space>gB', gs.toggle_current_line_blame, { desc = 'Toggle blame' })
end

return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require 'gitsigns'.setup {
      on_attach = on_attach,
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
  end
}
