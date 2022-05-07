local ok, devicons = pcall(require, 'nvim-web-devicons')
if not ok then
  return
end

-- TODO: figure out why require'nvim-web-devicons'.setup{ overrides = ...} ain't working
devicons.setup {}

local scala_files = { 'sc', 'sbt', 'scala'}
for _, ft in ipairs(scala_files) do
  require 'nvim-web-devicons'.set_icon {
    [ft] = {
      icon = "",
      color = "#cc3e44",
      cterm_color = "167",
      name = "Scala",
    }
  }
end

local conf_files = { 'properties'}
for _, ft in ipairs(conf_files) do
  require 'nvim-web-devicons'.set_icon {
    [ft] = {
    icon = "",
    color = "#6d8086",
    cterm_color = "66",
    name = "Conf",
    }
  }
end
