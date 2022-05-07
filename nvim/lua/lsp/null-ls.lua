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
      -- Code Actions
      null_ls.builtins.code_actions.gitsigns,

      -- Diagnostics
      -- null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.flake8,

      -- Formatting
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.goimports,

      -- Hover
      null_ls.builtins.hover.dictionary,
    },
  })
end
return M
