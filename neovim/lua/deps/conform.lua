local no_autosave_fts = { 'smithy' }
return {
  "stevearc/conform.nvim",
  event = 'BufReadPost',
  opts = {
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
      go = { "goimports", "gofumpt", "gofmt" },
      ocaml = { "ocamlformat" },
      http = { "kulalaformat" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
      kulalaformat = {
        command = "kulala-fmt",
        args = { "format", "$FILENAME" },
      },
      ocamlformat = { -- https://martinlwx.github.io/en/neovim-setup-for-ocaml/
        command = "ocamlformat",
        args = {
          "--if-then-else",
          "vertical",
          "--break-cases",
          "fit-or-vertical",
          "--type-decl",
          "sparse",
          -- $FILENAME - absolute path to the file
          "$FILENAME",
        },
      },
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
