local ok, comment = pcall(require, 'Comment')
if not ok then
  return
end

comment.setup({})

local ft = require('Comment.ft')

-- set line and block comment string
ft.sbt = {'//%s', '/*%s*/'}
