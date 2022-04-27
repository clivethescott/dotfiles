local sp = require("luasnip.nodes.snippetProxy") -- parse snippets on expansion
local utils = require 'utils'

return {
  s("uuid", {
    f(function() return utils.uuid() end, {}, {}),
  })
}
