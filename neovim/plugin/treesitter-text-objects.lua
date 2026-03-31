vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function()
    vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } })
    vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' } })

    local select_textobject = function(...)
      require "nvim-treesitter-textobjects.select".select_textobject(...)
    end
    local goto_next = function(...)
      require "nvim-treesitter-textobjects.move".goto_next_start(...)
    end
    local goto_previous = function(...)
      require "nvim-treesitter-textobjects.move".goto_previous_end(...)
    end

    -- You can use the capture groups defined in `textobjects.scm`
    vim.keymap.set({ 'x', 'o' }, 'af', function() select_textobject("@function.outer", "textobjects") end,
      { desc = 'Select outer function' })
    vim.keymap.set({ 'x', 'o' }, 'if', function() select_textobject("@function.inner", "textobjects") end,
      { desc = 'Select inner function' })
    -- This is similar to ]m, [m, Neovim's mappings to jump to the next or previous function.
    vim.keymap.set({ 'n', 'x', 'o' }, ']m',
      function() goto_next({ "@function.outer", "@class.outer" }, "textobjects") end,
      { desc = 'Go to next function or class' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[m',
      function() goto_previous({ "@function.outer", "@class.outer" }, "textobjects") end,
      { desc = 'Go to prev function or class' })
  end
})
