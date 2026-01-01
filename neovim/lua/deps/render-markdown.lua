return {
  "render-markdown.nvim",
  ft = { 'markdown', 'rust', 'codecompanion', 'python' },
  after = function()
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    require('render-markdown').setup({
      preset = 'obsidian',
      code = {
        disable_background = { 'diff', 'rust' },
      },
    })
  end,
}
