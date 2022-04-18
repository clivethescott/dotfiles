require 'nvim-web-devicons'.setup {
  -- your personal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    exe = {
      icon = "?",
      color = "#428850",
      cterm_color = "65",
      name = "Win Exe"
    },
    sbt = {
      icon = "",
      color = "#cc3e44",
      cterm_color = "167",
      name = "SBT Config",
    },
    sc = {
      icon = "",
      color = "#cc3e44",
      cterm_color = "167",
      name = "Scala worksheet",
    },
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
