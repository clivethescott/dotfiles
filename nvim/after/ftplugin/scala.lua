local opts = { silent = true, noremap = true, buffer = true }

local build = function()
  require 'toggleterm'.exec("scala-cli -q .")
end
vim.keymap.set('n', '<C-b>', build, opts)


local scala_files = { 'sc', 'sbt', 'scala' }
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

local conf_files = { 'properties' }
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
