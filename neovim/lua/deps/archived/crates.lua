return {
  'saecki/crates.nvim',
  event = { "BufRead Cargo.toml" },
  tag = 'stable',
  opts = {
    lsp = {
      enabled = true,
      on_attach = function(client, bufnr)
        require 'lsp'.on_attach(client, bufnr)
      end,
      actions = true,
      completion = true,
      hover = true,
    }
  },
  keys = {
    -- :Crates .... or hover
  },
}
