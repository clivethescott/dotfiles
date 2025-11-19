-- TODO: session management?  https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html
local keys = require 'keybinds'
local utils = require 'wez-utils'
local wezterm = require 'wezterm' --[[@as Wezterm]]
local mux = wezterm.mux

-- maximise window on startup Note that the gui-startup event does not fire when invoking wezterm connect DOMAIN or wezterm start --domain DOMAIN --attach
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('update-right-status', function(window, _)
  local date = wezterm.strftime '| %H:%M on %A %d %b '
  local status = window:active_workspace() .. ' ' -- .. ' @ ' .. pane:get_domain_name() .. ' '

  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#a6e3a1' } },
    { Text = status },
    { Foreground = { Color = '#f5e0dc' } },
    { Text = date },
  })
end)

wezterm.on('format-tab-title', function(tab, _)
  local zoomed = tab.active_pane.is_zoomed and '[Z] ' or ''
  local title = utils.tab_title(tab)
  return {
    { Text = ' ' .. tostring(tab.tab_index + 1) .. ': ' .. title .. '  ' .. zoomed },
  }
end)

local color_scheme = utils.patch_color_scheme('catppuccin-mocha')
local home_dir = wezterm.home_dir

---@type Config
return {
  term = 'wezterm',
  disable_default_key_bindings = true, -- https://wezfurlong.org/wezterm/config/default-keys.html?h=keys
  keys = keys.get(),
  mouse_bindings = keys.mouse(),
  set_environment_variables = {
    XDG_CONFIG_HOME = home_dir .. '/.config',
    XDG_DATA_HOME = home_dir .. '/.local/share',
    XDG_STATE_HOME = home_dir .. '/.local/state',
    XDG_CACHE_HOME = home_dir .. '/.cache',
  },
  hide_tab_bar_if_only_one_tab = false,
  font_size = 16.5,
  line_height = 1.3,
  scrollback_lines = 10000,
  font = wezterm.font('Hack Nerd Font Mono'),
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  tab_max_width = 30,
  -- color_scheme = 'catppuccin-mocha-patched',
  colors = {
    tab_bar = {
      background = '#323437',
    },
    cursor_fg = '#ffffff',
    cursor_bg = '#b55a5a',
  },
  color_scheme = 'Moonfly (Gogh)',
  window_decorations = "RESIZE",
  window_frame = {
    border_left_width = '1px',
    border_right_width = '1px',
    border_bottom_height = '1px',
    border_top_height = '1px',
    border_left_color = '#484848',
    border_right_color = '#484848',
    border_bottom_color = '#484848',
    border_top_color = '#484848',
  },
  audible_bell = "Disabled",
  window_close_confirmation = "NeverPrompt",
  color_schemes = {
    ['catppuccin-mocha-patched'] = color_scheme,
  },
  window_padding = {
    top = 5,
    left = 20,
    right = 10,
  },
  leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 2000 },
  -- quick_select_patterns = {
  -- [[^/Users/(?:\w|/|)+\.(?:txt|csv|scala)$]]
  -- },
  inactive_pane_hsb = {
    saturation = 0.2,
    brightness = 0.2,
  },
  -- unix_domains = {
  --   { name = 'remote' }
  -- },
  -- If you prefer to connect manually, leave out this line.
  -- default_gui_startup_args = { 'connect', 'unix' },
}
