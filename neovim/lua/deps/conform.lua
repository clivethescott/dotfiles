return {
  "stevearc/conform.nvim",
  event = 'BufReadPost',
  opts = {
    format_on_save = nil, -- will setup manually
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }
}
