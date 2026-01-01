local select_textobject = function(...)
  require "nvim-treesitter-textobjects.select".select_textobject(...)
end
local goto_next = function(...)
  require "nvim-treesitter-textobjects.move".goto_next_start(...)
end
local goto_previous = function(...)
  require "nvim-treesitter-textobjects.move".goto_previous_end(...)
end

return {
  'nvim-treesitter-textobjects',
  branch = 'main',
  keys = {
    -- You can use the capture groups defined in `textobjects.scm`
    {
      'af',
      function() select_textobject("@function.outer", "textobjects") end,
      desc = 'Select outer function',
      mode = { 'x', 'o' }
    },
    {
      'if',
      function() select_textobject("@function.inner", "textobjects") end,
      desc = 'Select inner function',
      mode = { 'x', 'o' }
    },
    -- This is similar to ]m, [m, Neovim's mappings to jump to the next or previous function.
    {
      ']m',
      function() goto_next({ "@function.outer", "@class.outer" }, "textobjects") end,
      desc = 'Go to next function or class',
      mode = { 'n', 'x', 'o' }
    },
    {
      '[m',
      function() goto_previous({ "@function.outer", "@class.outer" }, "textobjects") end,
      desc = 'Go to prev function or class',
      mode = { 'n', 'x', 'o' }
    }
  }
}
