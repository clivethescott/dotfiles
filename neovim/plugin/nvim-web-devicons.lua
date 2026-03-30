vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/nvim-tree/nvim-web-devicons', version = 'master' } })
  require('nvim-web-devicons').setup({
    override_by_extension = { -- some custom filetypes loaded later, prefer extension/filename
      http = {
        icon = " ",
        color = "#e37933",
        cterm_color = "65",
        name = "http"
      }
    }
  })
end)
