return {
  "ibhagwan/fzf-lua",
  event = 'VeryLazy',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      winopts = {
        height = 0.9,
        width = 0.9,
        preview = {
          default = 'bat',
          hidden = 'hidden'
        },
        on_create = function()
          -- called once upon creation of the fzf main window
          -- can be used to add custom fzf-lua mappings, e.g:
          vim.keymap.set("t", "<C-i>", "<F4>", { silent = true, buffer = true })
        end,
      },
    })
    require("fzf-lua").register_ui_select()


    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
      function() require("fzf-lua").complete_path() end,
      { silent = true, desc = "Fuzzy complete path" })

    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
      function() require("fzf-lua").lines() end,
      { silent = true, desc = "Buffer lines" })

    vim.keymap.set({ "n", "v", "i" }, "<C-x>s",
      function() require("fzf-lua").spell_suggest() end,
      { silent = true, desc = "Spell suggest" })

    vim.keymap.set("n", "<leader>2",
      function() require("fzf-lua").files { cwd = '~/.config/neovim' } end,
      { silent = true, desc = "Nvim files" })

    local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/lazy')
    vim.keymap.set("n", "<leader>5",
      function()
        require("fzf-lua").live_grep_glob { cwd = plugins_dir }
      end,
      { silent = true, desc = "Nvim files" })
  end,
  keys = {
    { "<c-p>",     "<cmd>FzfLua files<cr>",          desc = "FZF files" },
    { "<c-e>",     "<cmd>FzfLua buffers<cr>",        desc = "FZF buffers" },
    { "<space>tl", "<cmd>FzfLua resume<cr>",         desc = "FZF resume" },
    { "<space>tq", "<cmd>FzfLua quickfix<cr>",       desc = "FZF quickfix" },
    { "<space>tf", "<cmd>FzfLua live_grep_glob<cr>", desc = "FZF live grep" },
    { "<space>tF", "<cmd>FzfLua grep_cword<cr>",     desc = "FZF grep cword" },
    { "<space>tc", "<cmd>FzfLua commands<cr>",       desc = "FZF commands" },
    { "<space>th", "<cmd>FzfLua helptags<cr>",       desc = "FZF helptags" },
    { "<space>tm", "<cmd>FzfLua marks<cr>",          desc = "FZF marks" },
    { "<space>tr", "<cmd>FzfLua registers<cr>",      desc = "FZF registers" },
    { "<space>tb", "<cmd>FzfLua tmux_buffers<cr>",   desc = "FZF tmux paste" },
    {
      "<space>to",
      function() require 'fzf-lua'.oldfiles { include_current_session = true } end,
      desc = "FZF old files"
    },
  },
}
