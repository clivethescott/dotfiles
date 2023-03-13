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
      null_ls.builtins.code_actions.gitsigns, -- requires lewis6991/gitsigns.nvim

      -- Diagnostics
      -- null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.mypy,   -- pip install mypy
      null_ls.builtins.diagnostics.flake8, -- pip install flake8

      -- Formatting
      null_ls.builtins.formatting.autopep8, -- pip install autopep8
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.prettier, -- brew install prettier or equiv
      -- null_ls.builtins.formatting.goimports, -- go install golang.org/x/tools/cmd/goimports@latest

      -- Hover
      null_ls.builtins.hover.dictionary,
      -- null_ls.builtins.formatting.google_java_format, -- brew install google-java-format or equiv
    },
  })
end
return M
