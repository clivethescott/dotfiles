local M = {}
local wezterm = require 'wezterm' --[[@as Wezterm]]

M.mouse = function()
  return {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD|SHIFT',
      action = wezterm.action.OpenLinkAtMouseCursor,
    }
  }
end

M.get = function()
  local utils = require 'wez-utils'
  local lazygit = utils.run_cmd {
    '/opt/homebrew/bin/mise',
    'which',
    'lazygit'
  }
  local action = wezterm.action
  local all_characters = [[`1234567890=qwertyuiop[]\sdfghjklv;'zxcbnm./^*$#|?!]]
  local chars = {}

  -- convert string to list
  _ = all_characters:gsub('.', function(char) table.insert(chars, char) end)
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
    {
      key = 'x',
      mods = 'LEADER',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    { key = 'Q', mods = 'LEADER', action = wezterm.action.QuitApplication },
    {
      key = 'LeftArrow',
      mods = 'CMD',
      action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
      key = 'DownArrow',
      mods = 'CMD',
      action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    {
      key = 'UpArrow',
      mods = 'CMD',
      action = wezterm.action.AdjustPaneSize { 'Up', 2 },
    },
    {
      key = 'RightArrow',
      mods = 'CMD',
      action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },
    { key = 'K', mods = 'LEADER', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
    {
      key = 'L',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
      key = ':',
      mods = 'LEADER',
      action = wezterm.action.ActivateCommandPalette,
    },
    {
      key = '[',
      mods = 'LEADER',
      action = action.ActivateCopyMode -- default
    },
    {
      key = '{',
      mods = 'LEADER',
      action = action.QuickSelect -- default
    },
    {
      key = 'c',
      mods = 'LEADER',
      -- action = action.SpawnTab 'CurrentPaneDomain',
      action = wezterm.action.PromptInputLine {
        description = 'New tab name:',
        action = wezterm.action_callback(function(window, pane, line)
          -- https://github.com/wezterm/wezterm/issues/4845#issuecomment-1908772170
          if line then
            local tab, _, _ = window:mux_window():spawn_tab({
              domain = 'CurrentPaneDomain',
              title = line,
            })
            tab:set_title(line)
          end
        end),
      },
    },
    {
      key = 'C',
      mods = 'LEADER',
      action = wezterm.action.SpawnCommandInNewTab {
        -- set_environment_variables = { USE_Q = 'true' },
        args = { '/opt/homebrew/bin/nu' }
      },
    },
    {
      key = 'm',
      mods = 'LEADER',
      action = wezterm.action_callback(function(_, pane)
        pane:move_to_new_tab()
      end),
    },
    {
      key = 'M',
      mods = 'LEADER',
      action = wezterm.action_callback(function(_, pane)
        pane:move_to_new_window()
      end),
    },
    {
      mods   = 'LEADER',
      key    = 's',
      action = action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
      mods   = 'LEADER',
      key    = 'S',
      action = wezterm.action.SplitVertical {
        -- set_environment_variables = { USE_Q = 'true' },
        args = { '/opt/homebrew/bin/nu' }
      }
    },
    {
      mods   = 'LEADER',
      key    = 'v',
      action = action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
      mods   = 'LEADER',
      key    = 'V',
      action = wezterm.action.SplitHorizontal {
        -- set_environment_variables = { USE_Q = 'true' },
        args = { '/opt/homebrew/bin/nu' }
      }
    },
    {
      mods = 'LEADER',
      key = 'z',
      action = action.TogglePaneZoomState
    },
    {
      mods = 'LEADER',
      key = 'h',
      action = action.ActivatePaneDirection 'Left',
    },
    {
      mods = 'LEADER',
      key = 'l',
      action = action.ActivatePaneDirection 'Right',
    },
    {
      mods = 'LEADER',
      key = 'k',
      action = action.ActivatePaneDirection 'Up',
    },
    {
      mods = 'LEADER',
      key = 'j',
      action = action.ActivatePaneDirection 'Down',
    },
    -- pane selection mode
    {
      mods = 'LEADER',
      key = 'f',
      -- action = wezterm.action.PaneSelect {
      action = wezterm.action.PaneSelect {
        mode = 'Activate',
      },
    },
    {
      mods = 'LEADER',
      key = 'r',
      action = wezterm.action.PaneSelect {
        mode = 'SwapWithActive',
      },
    },
    {
      mods = 'LEADER',
      key = 'r',
      action = wezterm.action.RotatePanes 'Clockwise',
    },
    {
      mods = 'LEADER',
      key = 'g',
      action = wezterm.action.SpawnCommandInNewTab {
        args = { lazygit },
      }
    },
    {
      mods = 'LEADER',
      key = 'n',
      action = wezterm.action.ActivateTabRelative(1),
    },
    {
      mods = 'LEADER',
      key = 'Tab',
      action = wezterm.action.ActivateLastTab,
    },
    {
      mods = 'LEADER',
      key = 'p',
      action = wezterm.action.ActivateTabRelative(1),
    },
    { -- Rename tab title
      key = ',',
      mods = 'LEADER',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, _, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
    { -- rename session https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html
      key = '$',
      mods = 'LEADER',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for workspace',
        action = wezterm.action_callback(
          function(window, _, line)
            if line then
              wezterm.mux.rename_workspace(
                window:mux_window():get_workspace(),
                line
              )
            end
          end
        ),
      },
    },
    { -- Show the launcher in fuzzy selection mode and have it list all workspaces
      key = 't',
      mods = 'LEADER',
      action = wezterm.action.ShowLauncherArgs {
        flags = 'FUZZY|WORKSPACES|TABS',
      },
    },
    -- {
    --   key = 'r',
    --   mods = 'LEADER',
    --   action = wezterm.action.AttachDomain 'remote',
    -- },
    -- {
    --   key = 'R',
    --   mods = 'LEADER',
    --   action = wezterm.action.DetachDomain { DomainName = 'remote' },
    -- },
    { key = ')', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(1) },
    { key = '(', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(-1) },
    { -- Send 'CTRL-A' to the terminal when pressing CTRL-A, CTRL-A
      key = 'a',
      mods = 'LEADER|CMD',
      action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },

  }

  for _, char in ipairs(chars) do
    table.insert(result, {
      key = char,
      mods = 'CMD',
      action = action.SendKey { key = char, mods = 'CTRL' },
    })
  end

  -- now accepts negative numbers; these wrap around from the start of the tabs to the end,
  -- so -1 references the right-most tab, -2 the tab to its left and so on.
  for pane = 1, 8 do
    table.insert(result, {
      key = tostring(pane),
      mods = 'LEADER',
      action = wezterm.action.ActivateTab(pane - 1),
    })
    table.insert(result, {
      key = tostring(pane),
      mods = 'CMD|ALT',
      action = wezterm.action.MoveTab(pane - 1),
    })
  end
  return result
end
return M
