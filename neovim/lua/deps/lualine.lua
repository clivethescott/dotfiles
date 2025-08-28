local metals_status = function()
  return vim.g['metals_status'] or ''
end

local mcphub_status = {
  function()
    -- Check if MCPHub is loaded
    if not vim.g.loaded_mcphub then
      return "󰐻 -"
    end

    local count = vim.g.mcphub_servers_count or 0
    local status = vim.g.mcphub_status or "stopped"
    local executing = vim.g.mcphub_executing

    -- Show "-" when stopped
    if status == "stopped" then
      return "󰐻 -"
    end

    -- Show spinner when executing, starting, or restarting
    if executing or status == "starting" or status == "restarting" then
      local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      local frame = math.floor(vim.loop.now() / 100) % #frames + 1
      return "󰐻 " .. frames[frame]
    end

    return "󰐻 " .. count
  end,
  color = function()
    if not vim.g.loaded_mcphub then
      return { fg = "#6c7086" }                   -- Gray for not loaded
    end

    local status = vim.g.mcphub_status or "stopped"
    if status == "ready" or status == "restarted" then
      return { fg = "#50fa7b" }                   -- Green for connected
    elseif status == "starting" or status == "restarting" then
      return { fg = "#ffb86c" }                   -- Orange for connecting
    else
      return { fg = "#ff5555" }                   -- Red for error/stopped
    end
  end,
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { "gennaro-tedesco/nvim-possession" },
  event = 'VeryLazy',
  config = function()
    require 'lualine'.setup {
      options = {
        icons_enabled = false,
        theme = 'moonfly',
        globalstatus = true,
      },
      sections = {
        -- lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff',
          {
            'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_lsp', 'nvim_diagnostic' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
            },
            symbols = { error = 'E', warn = 'W' },
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          },
          -- { 'lsp_progress' }, -- provided by arkav/lualine-lsp-progress
          { metals_status }
        },
        lualine_c = {
          {
            'filename',
            file_status = true, -- Displays file status (readonly status, modified status)
            path = 1,           -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
            }
          },
        },
        lualine_x = { 'kulala', 'filetype', mcphub_status },
        lualine_y = { 'progress' },
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = { 'quickfix' }
    }
  end
}
