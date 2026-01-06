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
      vim.lsp.foldclose('comment', winid)
      vim.lsp.foldclose('imports', winid)
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

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('MyPacksChanged', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and kind ~= 'delete' then
      --TODO: check why this has issues sometimes
      local res = vim.system({ 'cargo build --release' }, { cwd = ev.data.path }):wait(10000) -- in millis
      if vim.v.shell_error ~= 0 then
        vim.notify('failed to compile blink.cmp:' .. res, vim.log.levels.ERROR)
      else
        vim.notify('blink successfully compiled', vim.log.levels.INFO)
      end
    else
      if name == 'nvim-treesitter' and kind ~= 'delete' then
      -- when changing between neovim head/stable
      -- see weird issues where new parsers don't install until old ones are removed
        vim.cmd('TSUpdate')
      end
    end
  end,
})

-- have imports organized on save using the logic of goimports and your code formatted.
-- https://go.dev/gopls/editor/vim
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('MyLspFuncs', { clear = true }),
  pattern = "*.go",
  callback = function()
    local range_params = vim.lsp.util.make_range_params(0, "utf-8")
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
