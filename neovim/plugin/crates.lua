  vim.pack.add({ { src = 'https://github.com/saecki/crates.nvim' } })

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
