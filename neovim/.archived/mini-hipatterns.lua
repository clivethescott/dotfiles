return {
  'mini.hipatterns',
  event = 'BufReadPost',
  after = function()
    require('mini.hipatterns').setup({
      highlighters = {
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      },
    })
  end,
}
