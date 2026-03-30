local no_autosave_fts = { 'smithy' }

vim.pack.add({ { src = 'https://github.com/stevearc/conform.nvim' } })
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require('conform').setup({
  default_format_opts = {
    lsp_format = "never",
  },
  format_after_save = function(bufnr)
    local ft = vim.b[bufnr].filetype
    if vim.tbl_contains(no_autosave_fts, ft) then
      return { lsp_format = "never" }
    else
      return {}   -- use defaults: https://github.com/stevearc/conform.nvim/issues/565
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
    markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
    ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    ocaml = { "ocamlformat" },
  },
  formatters = {
    ocamlformat = {
      prepend_args = {
        "--if-then-else", "vertical",
        "--break-cases", "fit-or-vertical",
        "--type-decl", "sparse",
      },
    },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require 'conform'.format({
    timeout_ms = 2000,
    async = false,
  })
end, { desc = 'Format' })
