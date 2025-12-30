local no_autosave_fts = { 'smithy' }
return {
  "conform.nvim",
  event = 'BufReadPost',
  after = function()
    require('conform').setup({
      default_format_opts = {
        lsp_format = "never",
      },
      format_after_save = function(bufnr)
        local ft = vim.b[bufnr].filetype
        if vim.tbl_contains(no_autosave_fts, ft) then
          return { lsp_format = "never" }
        else
          return {} -- use defaults: https://github.com/stevearc/conform.nvim/issues/565
        end
      end,
      quiet = true,
      notify_on_error = false,
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        go = { "gofumpt", "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        python = {
          -- To fix auto-fixable lint errors.
          -- "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
          lsp_format = "fallback"
        },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        formatters_by_ft = {
          ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
          ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        },
      },
    })
  end,
  before = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  keys = {
    { -- overridden on LSP attach
      '<leader>f',
      function()
        require 'conform'.format({
          timeout_ms = 2000,
          async = false,
        })
      end,
      mode = { 'n', 'v' },
      desc = 'Format'
    }
  }
}
