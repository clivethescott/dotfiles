local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'TermCursor',
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

local time_spent = nil

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    time_spent = vim.loop.hrtime()
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  desc = "Copy to clipboard on FocusLost",
  callback = function()
    if time_spent then
      local elapsed_ns = vim.loop.hrtime() - time_spent
      local elapsed_sec = elapsed_ns / 1e9
      if elapsed_sec > 2 then
        vim.fn.setreg("+", vim.fn.getreg("0"))
      end
    else
      vim.notify("Focus timer was not started.", vim.log.levels.WARN)
    end
  end,
})
vim.api.nvim_create_autocmd('FocusLost', {
  callback = function()
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
