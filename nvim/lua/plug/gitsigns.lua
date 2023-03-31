local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
  return
end

local map = vim.keymap.set
gitsigns.setup { on_attach = function()
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
  -- map('n', '<space>gB', blame_line)
  -- map('n', '<space>gb', gs.toggle_current_line_blame)
  -- map('n', '<space>gR', gs.reset_buffer)
  -- map('n', '<space>hS', gs.stage_buffer)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

  local wk = require 'which-key'
  wk.register({
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
end,
  signs = {
    add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '-', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '?', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
}
