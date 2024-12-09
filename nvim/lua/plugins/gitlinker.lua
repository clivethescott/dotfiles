return {
  'ruifm/gitlinker.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'VeryLazy',
  config = function()
    require 'gitlinker'.setup {
      print_url = false,
      mappings = nil,
      callbacks = {
        ["github.bamtech.co"] = require "gitlinker.hosts".get_github_type_url,
        ["github.twdcgrid.net"] = require "gitlinker.hosts".get_github_type_url,
      }
    }
  end
}
