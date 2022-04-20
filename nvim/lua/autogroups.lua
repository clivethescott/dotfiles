local api = vim.api

local restore_pos_group = vim.api.nvim_create_augroup('RestoreLastPos', { clear = true })
api.nvim_create_autocmd({ 'BufRead', 'BufReadPost' }, {
  desc = 'Restore last known position in file',
  group = restore_pos_group,
  pattern = '*',
  callback = function()
    local row, column = unpack(api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      api.nvim_win_set_cursor(0, { row, column })
    end
  end,
})

local format_on_save_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Files to format before save',
  group = format_on_save_group,
  pattern = { '*.scala', '*.python', '*.go', '*.lua' },
  callback = function()
    local timeoutMs = 1000
    local opts = nil
    vim.lsp.buf.formatting_sync(opts, timeoutMs)
  end,
})

-- vim.cmd[[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
