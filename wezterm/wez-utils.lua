local M = {}

---Runs a sys command and returns the output on success, empty string otherwise
---@param cmd string
---@return string
M.run_cmd = function(cmd)
  local handle = io.popen(cmd)
  if handle ~= nil then
    local out = handle:read('*a')
    handle:close()
    return out:gsub('[\n\r]', '') -- replace cmd newline
  else
    return ''
  end
end

-- This function returns the suggested title for a tab. It prefers 
-- the title that was set via `tab:set_title()` or `wezterm cli set-tab-title`, 
-- but falls back to the title of the active pane in that tab.
-- see https://wezterm.org/config/lua/window-events/format-window-title.html
---@param tab_info TabInformation
---@return string
M.tab_title = function(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

---Patches the provided built-in colorscheme
---@param builtin_color_scheme string Name of the built in color scheme to override
---@param wezterm any Wezterm config object
---@return string Modified color scheme
M.patch_color_scheme = function(builtin_color_scheme, wezterm)
  -- override colorscheme
  local color_scheme = wezterm.get_builtin_color_schemes()[builtin_color_scheme]
  -- https://catppuccin.com/palette/
  color_scheme.foreground = '#cdd6f4'
  color_scheme.split = '#6c7086'
  color_scheme.cursor_fg = '#11111b'
  color_scheme.cursor_bg = '#f5c2e7'
  color_scheme.selection_bg = '#fab387'
  color_scheme.selection_fg = '#313244'
  color_scheme.tab_bar = {
    background = '#1e1e2e',
    active_tab = {
      bg_color = '#313244',
      -- The color of the text for the tab
      fg_color = '#f5c2e7',
    },
    inactive_tab = {
      bg_color = '#1e1e2e',
      -- The color of the text for the tab
      fg_color = '#bac2de',
    }
  }
  return color_scheme
end

return M
