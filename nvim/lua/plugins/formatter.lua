return {
  "mhartington/formatter.nvim", -- non-LSP formatting support
  ft = { 'python' },
  config = function()
    require('formatter').setup {
      filetype = {
        python = {
          require 'formatter.filetypes.python'.ruff,
        },
        go = {
          require 'formatter.filetypes.go'.goimports,
        },
        json = {
          require 'formatter.filetypes.json'.prettier,
        },
        sql = {
          require 'formatter.filetypes.sql'.sqlfluff,
        },
        terraform = {
          require 'formatter.filetypes.terraform'.terraformfmt,
        },
        yaml = {
          require 'formatter.filetypes.yaml'.prettier,
        }
      }
    }
  end
}
