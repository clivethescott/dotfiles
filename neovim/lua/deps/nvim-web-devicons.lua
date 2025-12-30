return {
  'nvim-web-devicons',
  event = 'DeferredUIEnter',
  after = function()
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
  end,
}
