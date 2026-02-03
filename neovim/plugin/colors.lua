vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('MyColors', { clear = true }),
  callback = function(args)
    local colorscheme = args.match or vim.g.colors_name or 'default'
    local default_colorscheme = colorscheme == 'default'
    local catppuccin = colorscheme:find('catppuccin') ~= nil
    local status_bg = catppuccin and '#181825' or '#262626'

    -- statusline
    vim.api.nvim_set_hl(0, 'StatusLine', {
      bg = status_bg,
      fg = '#afafaf', -- Medium gray text
      bold = false,
    })

    vim.api.nvim_set_hl(0, 'StatusLineNC', {
      bg = '#1c1c1c', -- Darker for inactive
      fg = '#626262', -- Very dim text
    })
    vim.api.nvim_set_hl(0, 'StatusLineGitBranch', { link = '@string' })
    vim.api.nvim_set_hl(0, 'StatusLineGitAdded', { fg = '#6b8e5f', bg = status_bg })   -- Dimmed green
    vim.api.nvim_set_hl(0, 'StatusLineGitChanged', { fg = '#b89a5a', bg = status_bg }) -- Dimmed yellow
    vim.api.nvim_set_hl(0, 'StatusLineGitRemoved', { fg = '#b55a5a', bg = status_bg }) -- Dimmed red

    if not default_colorscheme then
      return
    end

    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#14161b' })
    -- see :h nvim-treesitter-context
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true })

    -- lines
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#626262' })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = status_bg })
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = status_bg })

    -- popup menus
    vim.api.nvim_set_hl(0, 'PMenuSel', { fg = '#7a96d6', bold = true })
    vim.api.nvim_set_hl(0, 'PMenu', { bg = '#000000' })

    -- folds
    vim.api.nvim_set_hl(0, 'Folded', { fg = '#b89a5a', bg = '#151f26' })

    -- snacks
    vim.api.nvim_set_hl(0, 'SnacksPickerListCursorLine', { bg = '#272828', bold = true })

    -- lsp
    vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = '#b89a5a' })
  end,
})

local colorscheme = vim.g.colors_name or 'default'
vim.cmd("colorscheme " .. colorscheme)
