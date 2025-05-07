local wezterm = require 'wezterm'
local mux = wezterm.mux
local action = wezterm.action

local cmd_bindings = function()
  local all_characters = [[`1234567890=qwertyuiop[]\asdfghjklv;'zxcbnm./^*$#|?!]]
  local chars = {}

  -- convert string to list
  _ = all_characters:gsub(".", function(char) table.insert(chars, char) end)
  local result = {
    {
      key = 'v',
      mods = 'CMD|SHIFT',
      action = action.PasteFrom 'Clipboard',
    },
    {
      key = 'r',
      mods = 'CMD|SHIFT',
      action = wezterm.action.ReloadConfiguration,
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
    -- {
    --   key = 'C',
    --   mods = 'LEADER',
    --   action = action.ActivateCopyMode
    -- },
    -- {
    --   key = 'c',
    --   mods = 'LEADER',
    --   action = action.SpawnTab 'CurrentPaneDomain',
    -- },
    -- {
    --   mods   = "LEADER",
    --   key    = "s",
    --   action = action.SplitVertical { domain = 'CurrentPaneDomain' }
    -- },
    -- {
    --   mods   = "LEADER",
    --   key    = "v",
    --   action = action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'z',
    --   action = action.TogglePaneZoomState
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'h',
    --   action = action.ActivatePaneDirection 'Left',
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'l',
    --   action = action.ActivatePaneDirection 'Right',
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'k',
    --   action = action.ActivatePaneDirection 'Up',
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'j',
    --   action = action.ActivatePaneDirection 'Down',
    -- },
    -- -- pane selection mode
    -- {
    --   mods = 'LEADER',
    --   key = 'f',
    --   action = wezterm.action.PaneSelect {
    --     mode = 'Activate',
    --   },
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'r',
    --   action = wezterm.action.PaneSelect {
    --     mode = 'SwapWithActive',
    --   },
    -- },
    -- {
    --   mods = 'LEADER',
    --   key = 'r',
    --   action = wezterm.action.RotatePanes 'Clockwise',
    -- },
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
  regex = [[(/Users/[\w./:]+)\S?\b]],
  format = "file:///$1",
})
-- relative file system URL e.g ~/Music/test.txt
table.insert(hyperlink_rules, {
  regex = [[~/([\w./:]+)\S?\b]],
  format = string.format("file:///Users/%s/$1", user_name),
})

table.insert(hyperlink_rules, {
  regex = '/Users[a-zA-Z0-9\\./-]+',
  format = '$0'
})

-- change action for open hyperlink
-- open doens't like file names with line numbers
wezterm.on('open-uri', function(window, pane, uri)
  local start, match_end = uri:find "file:///"
  if start == 1 then
    local path = uri:sub(match_end + 1)
    window:perform_action(
      wezterm.action.SpawnCommandInNewWindow {
        args = { '/opt/homebrew/bin/subl', path },
      },
      pane
    )
    -- prevent the default action from opening in a browser
    return false
  end
  -- otherwise, by not specifying a return value, we allow later
  -- handlers and ultimately the default action to caused the
  -- URI to be opened in the browser
end)

-- maximise window on startup
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  term = 'wezterm',
  disable_default_key_bindings = true, -- https://wezfurlong.org/wezterm/config/default-keys.html?h=keys
  keys = cmd_bindings(),
  mouse_bindings = mouse_bindings,
  hide_tab_bar_if_only_one_tab = true,
  font_size = 16.5,
  line_height = 1.3,
  scrollback_lines = 10000,
  font = wezterm.font('Hack Nerd Font Mono'),
  color_scheme = 'catppuccin-mocha',
  window_decorations = "RESIZE",
  audible_bell = "Disabled",
  window_close_confirmation = "NeverPrompt",
  hyperlink_rules = hyperlink_rules,
  -- leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 2000 },
  -- unix_domains = {
  --   { name = 'default' }
  -- },
  -- If you prefer to connect manually, leave out this line.
  -- default_gui_startup_args = { 'connect', 'default' },
}
