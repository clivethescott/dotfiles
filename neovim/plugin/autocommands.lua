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
      vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf))
    end
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup('MyLspAttach', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- if client.server_capabilities.inlayHintProvider then
      --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      -- end
      require 'lsp'.on_attach(client, bufnr)
    end
  end,
})

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
  jump = {
    float = true
  },
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
  pattern = 'VeryLazy',
  group = vim.api.nvim_create_augroup('MyDiagConfig', { clear = true }),
  callback = function()
    vim.diagnostic.config(diagnostic_config)
  end,
})
