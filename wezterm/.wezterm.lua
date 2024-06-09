-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local cmd_bindings = function()
  local all_characters = [[`1234567890-+=qwertyuiop[]\asdfghjkl;'zxcbnm./^*$#|?!]]
  local chars = {}

  _ = all_characters:gsub(".", function(char) table.insert(chars, char) end)
  local result = {}

  for _, char in ipairs(chars) do
    table.insert(result, {
      key = char,
      mods = 'CMD',
      action = wezterm.action.SendKey { key = char, mods = 'CTRL' },
    })
  end

  table.insert(result, {
      key = 'v',
      mods = 'CMD',
      action = act.PasteFrom 'Clipboard',
  })
  return result
end

-- maximise window on startup
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  term = 'wezterm',
  keys = cmd_bindings(),
  hide_tab_bar_if_only_one_tab = true,
  font_size = 15,
  font = wezterm.font 'FiraCode Nerd Font',
}
