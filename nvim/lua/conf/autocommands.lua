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
      vim.api.nvim_exec('normal zz', false)
    end
  end,
})

api.nvim_create_autocmd({ 'BufWritePost' }, {
  desc = 'LSP format before save',
  group = events_group,
  pattern = { '*.scala', '*.sc', '*.go', '*.java', '*.rs', },
  callback = function(ev)
    require 'helper.utils'.lsp_buf_format_sync(ev)
  end,
})

api.nvim_create_autocmd({ 'BufWritePost' }, {
  desc = 'Formatter nvim format before save',
  group = events_group,
  pattern = { '*.py' },
  callback = function()
    vim.cmd ":FormatWrite"
  end,
})

api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
  desc = 'Refresh code lens',
  group = events_group,
  pattern = { '*.py', '*.scala', '*.go', '*.java', '*.rust' },
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.id)
    if client and client.supports_method('textDocument/codeLens') then
      vim.lsp.codelens.refresh({ bufnr = 0 })
    end
  end,
})
-- Some filetype plugins will reset formatoptions, hence needed this way
-- api.nvim_create_autocmd({ 'FileType' }, {
--   desc = 'Dont auto-continue comments',
--   group = events_group,
--   pattern = { '*' },
--   callback = function()
--     vim.opt_local.formatoptions:remove { 'c', 'r', 'o' } -- :h fo-table
--   end,
-- })

api.nvim_create_autocmd({ 'BufWritePost' }, {
  desc = 'Auto re-source luasnip config',
  group = events_group,
  pattern = { 'luasnip.lua' },
  callback = function()
    vim.cmd 'source ~/.config/nvim/lua/plugins/luasnip.lua'
  end,
})

api.nvim_create_autocmd({ "BufWritePost" }, {
  group = events_group,
  pattern = { '*.clj', '*.py' },
  callback = function()
    require("lint").try_lint()
  end,
})

api.nvim_create_autocmd({ "BufReadPost" }, {
  desc = 'Listchars for indentation based languages',
  group = events_group,
  pattern = { '*.py', '*.yaml', '*.yml', '*.sc' },
  callback = function()
    vim.wo.list = true
    vim.wo.listchars = "leadmultispace:·"
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    require 'cmp'.setup.buffer({ sources = { { name = "crates" } } })
  end,
})
