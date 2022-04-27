local tail = function(arg, split_by)
  local literal = true -- not a regex
  local parts = vim.split(arg, split_by, literal)
  return parts[#parts] or ""
end

return {
  s("todo", c(1, {
    t "TODO: ",
    t "fixme: ",
  })),
  s("req", fmt([[local {} = require"{}"]], {
    f(function(import_name) return tail(import_name[1][1], ".") end, { 1 }),
    i(1)
  })
  )
}
