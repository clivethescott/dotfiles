vim.api.nvim_create_autocmd('FileType', {
  once = true,
  pattern = { 'markdown', 'rust', 'codecompanion', 'python' },
  callback = function()
    vim.pack.add({ { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' } })
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    require('render-markdown').setup({
      preset = 'obsidian',
      completions = {
        lsp = { enabled = true }
      },
      code = {
        disable_background = { 'diff', 'rust' },
      },
    })
  end
})
