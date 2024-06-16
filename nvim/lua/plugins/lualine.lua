local function metals_status()
  return vim.g['metals_status'] or ''
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'folke/trouble.nvim' },
  event = 'VeryLazy',
  opts = function()
    local symbols = require'trouble'.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = 'catppuccin-macchiato',
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
            path = 0,           -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path

            shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
            }
          },
          { -- trouble
            symbols.get,
            cond = symbols.has,
          },
        },
        lualine_x = { 'filetype' },
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
      extensions = {'oil'}
    }
  end
}
