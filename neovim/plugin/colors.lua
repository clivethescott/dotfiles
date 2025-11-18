vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('MyColors', { clear = true }),
  callback = function(args)
    local colorscheme = args.match or vim.g.colors_name or 'default'
    local default_colorscheme = colorscheme == 'default'
    if not default_colorscheme then
      vim.notify('Non-default colorscheme, disabling overrides', vim.log.levels.INFO)
      return
    end

    -- statusline
    vim.api.nvim_set_hl(0, 'StatusLine', {
      bg = '#262626', -- Subtle dark gray
      fg = '#afafaf', -- Medium gray text
      bold = false,
    })

    vim.api.nvim_set_hl(0, 'StatusLineNC', {
      bg = '#1c1c1c',                                                                  -- Darker for inactive
      fg = '#626262',                                                                  -- Very dim text
    })
    vim.api.nvim_set_hl(0, 'StatusLineGitAdded', { fg = '#6b8e5f', bg = '#262626' })   -- Dimmed green
    vim.api.nvim_set_hl(0, 'StatusLineGitChanged', { fg = '#b89a5a', bg = '#262626' }) -- Dimmed yellow
    vim.api.nvim_set_hl(0, 'StatusLineGitRemoved', { fg = '#b55a5a', bg = '#262626' }) -- Dimmed red

    -- nicer colors for markdown headers
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { fg = '#e06c75', bg = '#2c1f1f', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { fg = '#d19a66', bg = '#2c251f', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { fg = '#e5c07b', bg = '#2c2a1f', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { fg = '#61afef', bg = '#1f252c', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { fg = '#c678dd', bg = '#261f2c', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { fg = '#56b6c2', bg = '#1f2a2c', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#0f1211', bold = false })
    vim.api.nvim_set_hl(0, 'PMenuSel', { fg = '#7a96d6', bold = true })
    vim.api.nvim_set_hl(0, 'PMenu', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'Folded', { bg = '#2e3d2e' })
  end,
})
