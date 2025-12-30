return {
  "render-markdown.nvim",
  -- lazy = false, Lazy-loading will cause more time for the previews to load when starting Neovim?
  ft = { 'markdown', 'rust', 'codecompanion', 'python' },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  after = function()
    require('render-markdown').setup({
      preset = 'obsidian',
      code = {
        disable_background = { 'diff', 'rust' },
      },
    })
  end,
}
