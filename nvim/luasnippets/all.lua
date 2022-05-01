local utils = require 'helper.utils'

return {
  s({ trig = "uuid", name = "UUID", dscr = "Generate a UUID" }, {
    f(function() return utils.uuid() end, {}, {}),
  }),
  s("time", f(function()
    return os.date "%D - %H:%M"
  end)),
}
