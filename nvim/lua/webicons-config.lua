require 'nvim-web-devicons'.setup {
  -- your personal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    ['sbt'] = {
      icon = "",
      color = "#cc3e44",
      cterm_color = "167",
      name = "sbt",
    },
    ['sc'] = {
      icon = "",
      color = "#cc3e44",
      cterm_color = "167",
      name = "sc",
    },
  }
}
