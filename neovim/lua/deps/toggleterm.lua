local lazygit = nil

return {
  'akinsho/toggleterm.nvim',
  cmd = 'ToggleTerm',
  keys = {
    [[<C-\>]],
    {
      'gs',
      function()
        if lazygit ~= nil then
          lazygit:toggle()
        else
          local Terminal = require('toggleterm.terminal').Terminal
          lazygit        = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'tab' })
          lazygit:toggle()
        end
      end,
      desc = 'Toggle lazygit'
    },
  },
  version = '*',
  opts = {
    open_mapping = [[<c-\>]],
    direction = 'float',  -- 'vertical' | 'horizontal' | 'tab' | 'float',
    start_in_insert = true,
    close_on_exit = true, -- close the terminal window when the process exits
    float_opts = {
      border = 'curved',  -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    },
  }
}
