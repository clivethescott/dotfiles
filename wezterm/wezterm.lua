-- TODO: session management?  https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html
local keys = require 'keybinds'
local utils = require 'wez-utils'
local wezterm = require 'wezterm' --[[@as Wezterm]]
local mux = wezterm.mux

-- maximise window on startup
-- Note that the gui-startup event does not fire when invoking wezterm connect DOMAIN or wezterm start --domain DOMAIN --attach.
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('update-right-status', function(window, _)
  local date = wezterm.strftime '%H:%M | %A %d %b'
  local status = window:active_workspace() .. ' ' -- .. ' @ ' .. pane:get_domain_name() .. ' '

  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#f5e0dc' } },
    { Text = date .. ' | ' },
    { Foreground = { Color = '#a6e3a1' } },
    { Text = status },
  })
end)

wezterm.on('format-tab-title', function(tab, _)
  local zoomed = tab.active_pane.is_zoomed and '[Z] ' or ''
  local title = utils.tab_title(tab)
  return {
    { Text = '  ' .. title .. '  ' .. zoomed },
  }
end)

local color_scheme = utils.patch_color_scheme('catppuccin-mocha')

return {
  term = 'wezterm',
  disable_default_key_bindings = true, -- https://wezfurlong.org/wezterm/config/default-keys.html?h=keys
  keys = keys.get(),
  mouse_bindings = keys.mouse(),
  hide_tab_bar_if_only_one_tab = false,
  font_size = 16.5,
  line_height = 1.3,
  scrollback_lines = 10000,
  font = wezterm.font('Hack Nerd Font Mono'),
  use_fancy_tab_bar = false,
  tab_max_width = 30,
  color_scheme = 'catppuccin-mocha-patched',
  window_decorations = "RESIZE",
  audible_bell = "Disabled",
  window_close_confirmation = "NeverPrompt",
  color_schemes = {
    ['catppuccin-mocha-patched'] = color_scheme,
  },
  window_padding = {
    top = 5,
    left = 5,
  },
  leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 2000 },
  -- quick_select_patterns = {
  -- [[^/Users/(?:\w|/|)+\.(?:txt|csv|scala)$]]
  -- },
  inactive_pane_hsb = {
    saturation = 0.4,
    brightness = 0.4,
  },
  -- unix_domains = {
  --   { name = 'remote' }
  -- },
  -- If you prefer to connect manually, leave out this line.
  -- default_gui_startup_args = { 'connect', 'unix' },
}
