-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local action = wezterm.action

local cmd_bindings = function()
  local all_characters = [[`1234567890=qwertyuiop[]\asdfghjkl;'zxcbnm./^*$#|?!]]
  local chars = {}

  -- convert string to list
  _ = all_characters:gsub(".", function(char) table.insert(chars, char) end)
  local result = {
    {
      key = 'v',
      mods = 'CMD',
      action = action.PasteFrom 'Clipboard',
    },
    {
      key = '-',
      mods = 'CMD',
      action = action.DecreaseFontSize
    },
    {
      key = '+',
      mods = 'CMD',
      action = action.IncreaseFontSize
    },
    {
      key = 'q',
      mods = 'CMD|OPT',
      action = action.QuitApplication
    },
    {
      key = 'f',
      mods = 'CMD|SHIFT',
      action = action.Search({ CaseInSensitiveString = '' })
    },
    {
      key = 'Enter',
      mods = 'CMD',
      action = action.ActivateCopyMode
    },
    {
      key = 'C',
      mods = 'CMD|SHIFT',
      action = action.ActivateCopyMode
    },
  }

  for _, char in ipairs(chars) do
    table.insert(result, {
      key = char,
      mods = 'CMD',
      action = action.SendKey { key = char, mods = 'CTRL' },
    })
  end

  return result
end

local mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = action.OpenLinkAtMouseCursor,
  },
}

local hyperlink_rules = wezterm.default_hyperlink_rules()
local user_name = os.getenv('USER') or 'clive'
-- absolute file system URL e.g /Users/clive/Music/test.txt
table.insert(hyperlink_rules, {
  regex = [[(/Users/[\w./]+)\S?\b]],
  format = "file:///$1",
})
-- relative file system URL e.g ~/Music/test.txt
table.insert(hyperlink_rules, {
  regex = [[~/([\w./]+)\S?\b]],
  format = string.format("file:///Users/%s/$1", user_name),
})

-- maximise window on startup
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  term = 'wezterm',
  keys = cmd_bindings(),
  mouse_bindings = mouse_bindings,
  hide_tab_bar_if_only_one_tab = true,
  font_size = 15,
  line_height = 1.2,
  scrollback_lines = 10000,
  font = wezterm.font 'FiraCode Nerd Font',
  color_scheme = 'catppuccin-mocha',
  window_decorations = "RESIZE",
  audible_bell = "Disabled",
  window_close_confirmation = "NeverPrompt",
  hyperlink_rules = hyperlink_rules,
}
