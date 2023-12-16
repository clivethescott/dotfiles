return {
  "mfussenegger/nvim-lint",
  ft = { 'python', 'go', 'yaml' },
  config = function()
    require("lint").linters_by_ft = {
      python = { "flake8", "mypy", "ruff" },
      go = { "golangcilint" },
      yaml = { "yamllint", "cfn_lint", "cfn_nag" },
      sql = { "sqlfluff", },
    }
  end,
}
