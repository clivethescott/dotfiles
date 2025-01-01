return {
  "stevearc/conform.nvim",
  event = 'BufReadPost',
  opts = {
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
  init = function()
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
