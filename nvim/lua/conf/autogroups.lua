local api = vim.api

local events_group = vim.api.nvim_create_augroup('CustomEventsGroup', { clear = true })

api.nvim_create_autocmd({ 'BufReadPost' }, {
  desc = 'Restore last known position in file',
  group = events_group,
  pattern = '*',
  callback = function()
    local row, column = unpack(api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      api.nvim_win_set_cursor(0, { row, column })
    end
  end,
})

api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Files to format before save',
  group = events_group,
  pattern = { '*.scala', '*.sc', '*.py', '*.go', '*.lua' },
  callback = function()
    local timeoutMs = 2000
    local opts = {}
    vim.lsp.buf.formatting_sync(opts, timeoutMs)
  end,
})

-- Some filetype plugins will reset formatoptions, hence needed this way
api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'Dont auto-continue comments',
  group = events_group,
  pattern = { '*' },
  callback = function()
    vim.opt.formatoptions:remove('c'):remove('r'):remove('o') -- :h fo-table
  end,
})

api.nvim_create_autocmd({ 'BufWritePost' }, {
  desc = 'Auto re-source luasnip config',
  group = events_group,
  pattern = { 'luasnip.lua' },
  callback = function()
    vim.cmd 'source ~/.config/nvim/lua/plug/luasnip.lua'
  end,
})

-- vim.cmd[[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
