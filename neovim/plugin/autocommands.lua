local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'CurSearch',
      timeout = 500 -- time in ms before highlight is cleared
    }
  end,
  group = highlight_group,
  pattern = '*',
})

-- To automatically fold imports when opening a file, see :h vim.lsp.foldclose
vim.api.nvim_create_autocmd('LspNotify', {
  group = vim.api.nvim_create_augroup('MyLspNotify', { clear = true }),
  callback = function(args)
    if args.data.method == 'textDocument/didOpen' then
      local winid = vim.fn.bufwinid(args.buf) or 0
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client:supports_method('textDocument/foldingRange', args.buf) then
        vim.lsp.foldclose('comment', winid)
        vim.lsp.foldclose('imports', winid)
      end
    end
  end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   group = vim.api.nvim_create_augroup('MyVimStartup', { clear = true }),
--   callback = function(args)
--     -- when directly opening a file or dir, don't launch fzf
--     local has_launch_args = args.file ~= ""
--     if not has_launch_args then
--       local has_fzf_lua, fzf_lua = pcall(require, 'fzf-lua')
--       if has_fzf_lua then
--         fzf_lua.combine({
--           pickers = { 'oldfiles', 'files' },
--           winopts = {
--             title = 'Recent + Dir Files'
--           },
--         })
--       end
--     end
--   end,
-- })
--
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd('BufRead', {
  pattern = { '*.lua', '*.scala', '*.rust', '*.conf', '*.smithy' },
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true, -- set to false to run this multiple times
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
            not (ft:match('commit') and ft:match('rebase'))
            and last_known_line > 1
            and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
  group = vim.api.nvim_create_augroup('RestorePos', { clear = true }),
})

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_config = {
  float = true,
  -- jump = {
  --   float = true
  -- },
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },
  -- Show all diagnostics as underline
  underline = { severity = { min = 'HINT', max = 'ERROR' } },
  -- virtual_lines = true,
  -- Alternatively, customize specific options
  virtual_lines = false,
  -- virtual_lines = {
  -- Only show virtual line diagnostics for the current cursor line
  -- current_line = true,
  -- },
  virtual_text = {
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
  },
  update_in_insert = false,
  severity_sort = true,
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'DeferredUIEnter',
  group = vim.api.nvim_create_augroup('MyDiagConfig', { clear = true }),
  callback = function()
    vim.diagnostic.config(diagnostic_config)
  end,
})

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update(nil, { force = true })
end, { desc = 'Update plugins' })


-- :h vim.pack Synchronize config across machines ~
vim.api.nvim_create_user_command('PackSync', function()
  vim.pack.update(nil, { target = 'lockfile' })
end, { desc = 'Sync plugin state' })


-- :h nvim_open_term
-- https://www.youtube.com/watch?v=EiBg91LTOYk&t=3947s
vim.api.nvim_create_user_command('TermHl', function()
  vim.api.nvim_open_term(0, {})
end, { desc = 'Highlights ANSI termcodes in curbuf' })

local lsp_group = vim.api.nvim_create_augroup('MyLspFuncs', { clear = true })

-- have imports organized on save using the logic of goimports and your code formatted.
-- https://go.dev/gopls/editor/vim
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  group = lsp_group,
  callback = function()
    local range_params = vim.lsp.util.make_range_params(0, "utf-8")
    ---@diagnostic disable-next-line: inject-field
    range_params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", range_params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-8"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end
})


-- https://www.reddit.com/r/neovim/comments/1rcvliq/ghostty_lsp_progress_bar
vim.api.nvim_create_autocmd("LspProgress", {
  group = lsp_group,
  callback = function(ev)
    local value = ev.data.params.value or {}
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local client_name = client and client.name or 'unknown'
    -- if client_name == 'lua_ls' and string.find(value.title,  'Diagnosing workspace') then return end
    local msg = value.message or "done"

    -- rust analyszer in particular has really long LSP messages so truncate them
    if #msg > 60 then
      msg = msg:sub(1, 57) .. "..."
    end

    -- :h LspProgress
    vim.api.nvim_echo({ { msg } }, false, {
      id = "lsp",
      kind = "progress",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
      source = client_name,
    })
  end,
})
