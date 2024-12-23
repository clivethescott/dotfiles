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

    vim.keymap.set('v', '<space>gh',
      function()
        require "gitlinker".get_buf_range_url('v',
          { action_callback = require "gitlinker.actions".open_in_browser })
      end, { desc = 'Open in Github' })
    vim.keymap.set('n', '<space>gH',
      function() require "gitlinker".get_repo_url({ action_callback = require "gitlinker.actions".open_in_browser }) end,
      { desc = 'Open in Github' })
  end
}
