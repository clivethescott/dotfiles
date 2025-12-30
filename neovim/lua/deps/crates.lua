return {
  'crates.nvim',
  event = { "BufRead Cargo.toml" },
  after = function()
    require('crates').setup({
      lsp = {
        enabled = true,
        on_attach = function(client, bufnr)
          require 'lsp'.on_attach(client, bufnr)
        end,
        actions = true,
        completion = true,
        hover = true,
      }
    })
  end,
  keys = {
    -- :Crates .... or hover
  },
}
