local on_attach = function()
  local map = vim.keymap.set
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
  local blame_line = function()
    gs.blame_line { full = true }
  end

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

  local wk = require 'which-key'
  wk.register({
    ["["] = {
      name = '+Previous',
      g = { prev_hunk, 'Git Change' },
    },
    ["]"] = {
      name = '+Next',
      g = { next_hunk, 'Git Change' },
    },
    ["<space>"] = {
      g = {
        name = '+Git',
        [']'] = { next_hunk, 'Next Change' },
        ['['] = { prev_hunk, 'Prev Change' },
        b = { gs.toggle_current_line_blame, 'Toggle Blame' },
        B = { blame_line, 'Blame Line Full' },
        d = { gs.preview_hunk, 'Diff Change' },
        u = { gs.reset_hunk, 'Undo Current Change' },
        U = { gs.reset_buffer, 'Undo Buffer Changes' },
      },
    }
  })
end

return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "folke/which-key.nvim",
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
