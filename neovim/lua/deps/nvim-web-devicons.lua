return {
  'nvim-tree/nvim-web-devicons',
  opts = {
    override_by_extension = { -- some custom filetypes loaded later, prefer extension/filename
      http = {
        icon = " ",
        color = "#e37933",
        cterm_color = "65",
        name = "http"
      }
    }
  },
}
