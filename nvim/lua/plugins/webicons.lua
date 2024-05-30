return {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  config = function()
    require 'nvim-web-devicons'.setup {
      override_by_extension = {
        [".properties"] = {
          icon = "",
          color = "#6d8086",
          cterm_color = "66",
          name = "Conf",
        },
        [".sc"] = {
          icon = "",
          color = "#cc3e44",
          cterm_color = "167",
          name = "Scala",
        },
        [".scala"] = {
          icon = "",
          color = "#cc3e44",
          cterm_color = "167",
          name = "Scala",
        },
        [".sbt"] = {
          icon = "",
          color = "#cc3e44",
          cterm_color = "167",
          name = "Scala",
        },
      },
    }
  end
}
