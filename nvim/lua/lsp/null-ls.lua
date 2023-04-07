local M = {}

M.setup = function(on_attach)
  local ok, null_ls = pcall(require, 'null-ls')
  if not ok then
    return
  end
  null_ls.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    sources = {
      null_ls.builtins.code_actions.eslint,
      -- The external tools for these are managed via williamboman/mason.nvim
      -- Code Actions
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.gomodifytags,
      null_ls.builtins.diagnostics.buf,

      -- Diagnostics & Linters
      null_ls.builtins.diagnostics.cfn_lint,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.ruff,
      null_ls.builtins.diagnostics.terraform_validate,
      null_ls.builtins.diagnostics.yamllint,

      -- Formatting
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.buf,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.terraform_fmt,
      null_ls.builtins.formatting.yamlfmt,
      null_ls.builtins.formatting.tidy,

      -- Hover
      null_ls.builtins.hover.dictionary,

    },
  })
end
return M
