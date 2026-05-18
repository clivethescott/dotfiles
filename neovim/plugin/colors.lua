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

    -- gitsigns (applies to all colorschemes)
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#6b8e5f' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#b89a5a' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#b55a5a' })
    vim.api.nvim_set_hl(0, 'GitSignsTopDelete', { fg = '#b55a5a' })

    -- gitsigns inline / blame (prevents white TermCursor fallback)
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#626262' })
    vim.api.nvim_set_hl(0, 'GitSignsAddPreview', { bg = '#1e2e1e' })
    vim.api.nvim_set_hl(0, 'GitSignsDeletePreview', { bg = '#2e1e1e' })
    vim.api.nvim_set_hl(0, 'GitSignsAddInline', { bg = '#2d422d' })
    vim.api.nvim_set_hl(0, 'GitSignsChangeInline', { bg = '#354563' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { bg = '#422d2d' })
    vim.api.nvim_set_hl(0, 'GitSignsAddLnInline', { bg = '#2d422d' })
    vim.api.nvim_set_hl(0, 'GitSignsChangeLnInline', { bg = '#354563' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteLnInline', { bg = '#422d2d' })

    -- completion kind + extra columns (grayed out, applies to all colorschemes)
    vim.api.nvim_set_hl(0, 'PmenuKind', { fg = '#767676' })
    vim.api.nvim_set_hl(0, 'PmenuKindSel', { fg = '#767676', bold = true })
    vim.api.nvim_set_hl(0, 'PmenuExtra', { fg = '#767676' })
    vim.api.nvim_set_hl(0, 'PmenuExtraSel', { fg = '#767676' })

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

    -- diffs / merges
    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#1e2e1e' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#2e1e1e' })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#252f42' })
    vim.api.nvim_set_hl(0, 'DiffText', { bg = '#2a3a52', bold = true })

    vim.api.nvim_set_hl(0, 'Statement', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, 'Conditional', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, 'Repeat', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, 'Exception', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, 'Include', { fg = '#a4b4d4' })
    vim.api.nvim_set_hl(0, '@keyword', { fg = '#b4a0d1', bold = true })
    vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, '@keyword.repeat', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, '@keyword.return', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, '@keyword.exception', { fg = '#b4a0d1' })
    vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#a4b4d4' })
    vim.api.nvim_set_hl(0, '@keyword.import', { fg = '#a4b4d4' })
    vim.api.nvim_set_hl(0, '@keyword.operator', { fg = '#a09ab8' })

    -- lsp
    vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = '#b89a5a' })
  end,
})

local colorscheme = vim.g.colors_name or 'default'
vim.cmd("colorscheme " .. colorscheme)
