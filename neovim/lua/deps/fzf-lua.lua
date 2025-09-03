local ignore_files = { "^%.metals", "^%.scala", "^Gemfile.lock" }
return {
  "ibhagwan/fzf-lua",
  event = 'VeryLazy',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cond = vim.g.use_picker == 'fzf-lua',
  config = function()
    local actions = require("fzf-lua").actions
    require("fzf-lua").setup({
      fzf_opts = {
        -- ["--layout"] = "default", -- prompt at bottom
        ["--cycle"] = true
      },
      file_ignore_patterns = { "%.bsp", "%_build", "%.obsidian", "%.scala_build", '%.idea', '%.terraform' },
      actions = {
        files = { -- actions.files is inherited by: files, git_files, git_status, grep....
          ['ctrl-q']  = { fn = actions.file_edit_or_qf, prefix = 'select-all+' },
          ["alt-q"]   = actions.file_sel_to_qf,
          ["default"] = actions.file_edit_or_qf, -- enter
          ["alt-s"]   = actions.file_split,
          ["alt-v"]   = actions.file_vsplit,
          ["alt-t"]   = actions.file_tabedit,
          ["alt-f"]   = actions.toggle_hidden,
          ["alt-g"]   = actions.toggle_ignore,
        },
      },
      commands = { -- https://github.com/ibhagwan/fzf-lua/pull/1603#issuecomment-2554925844
        actions = {
          ["ctrl-f"] = actions.ex_run,
          ["enter"] = actions.ex_run_cr,
          -- ["alt-enter"] = actions.ex_run,
        }
      },
      files = {
        hidden = true,
        follow = false,
      },
      grep = {
        rg_glob   = true,
        glob_flag = "--iglob",
      },
      winopts = {
        height = 0.9,
        width = 0.9,
        preview = {
          default = 'bat',
          hidden = 'hidden'
        },
        files = {
          git_icons = false,
        },
        on_create = function()
          -- called once upon creation of the fzf main window
          -- can be used to add custom fzf-lua mappings, e.g:
          vim.keymap.set("t", "<M-i>", "<F4>", { silent = true, buffer = true })
        end,
      },
    })
    require("fzf-lua").register_ui_select()
    vim.keymap.set({ "i" }, "<C-x><C-f>",
      function() require("fzf-lua").complete_path() end,
      { silent = true, desc = "FZF complete path" })


    vim.keymap.set({ "i" }, "<C-x><C-l>",
      function() require("fzf-lua").complete_line() end,
      { silent = true, desc = "FZF complete lines" })

    vim.keymap.set({ "i" }, "<C-x>s",
      function() require("fzf-lua").spell_suggest() end,
      { silent = true, desc = "FZF Spell suggest" })

    vim.keymap.set("n", "<leader>2",
      function() require("fzf-lua").files { cwd = '~/.config/nvim' } end,
      { silent = true, desc = "Nvim files" })

    vim.keymap.set("n", "<leader>3",
      function() require("fzf-lua").live_grep_glob { cwd = '~/.config/nvim' } end,
      { silent = true, desc = "Nvim files" })

    local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/lazy')
    vim.keymap.set("n", "<leader>4",
      function() require("fzf-lua").files { cwd = plugins_dir } end,
      { silent = true, desc = "Nvim plugin files" })
    vim.keymap.set("n", "<leader>5",
      function() require("fzf-lua").live_grep_glob { cwd = plugins_dir } end,
      { silent = true, desc = "Nvim plugin grep" })

    vim.keymap.set("n", "<space>ro",
      function() require("fzf-lua").files { cwd = '~/Code/Hurl' } end,
      { silent = true, desc = "Hurl files" })
  end,
  keys = {
    {
      "<c-p>",
      function()
        require("fzf-lua").files({ file_ignore_patterns = ignore_files })
      end,
      desc = "FZF files"
    },
    {
      "<M-p>",
      function()
        require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "FZF files (lwd)"
    },
    { "<c-e>",     "<cmd>FzfLua buffers<cr>",  desc = "Buffers" },
    { "<space>tl", "<cmd>FzfLua resume<cr>",   desc = "Resume" },
    { "<space>tq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix" },
    -- { "<space>tf", "<cmd>FzfLua live_grep_glob<cr>", desc = "Live grep" },
    {
      "<space>tf",
      function() require 'fzf-lua'.live_grep_glob({ file_ignore_patterns = ignore_files }) end,
      desc = "Live grep"
    },
    { "<space>tF",  "<cmd>FzfLua grep_cWORD<cr>",                 desc = "Grep cword" },
    { "<space>tc",  "<cmd>FzfLua commands<cr>",                   desc = "Commands" },
    { "<space>th",  "<cmd>FzfLua helptags<cr>",                   desc = "Helptags" },
    { "<space>tt",  "<cmd>FzfLua tagstack<cr>",                   desc = "Tagstack" },
    { "<space>tw",  "<cmd>FzfLua spell_suggest<cr>",              desc = "Spell Suggest" },
    { "<space>tm",  "<cmd>FzfLua marks<cr>",                      desc = "Marks" },
    { "<space>tr",  "<cmd>FzfLua registers<cr>",                  desc = "Registers" },
    { "<space>tb",  "<cmd>FzfLua lines<cr>",                      desc = "Open Buffers lines" },
    { "<space>tz",  "<cmd>FzfLua zoxide<cr>",                     desc = "Zoxide" },
    { "<space>lw",  "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "LSP workspace symbols" },
    { "<space>ldo", "<cmd>FzfLua diagnostics_document<cr>",       desc = "Diagnostics" },
    { "gR",         "<cmd>FzfLua lsp_references<cr>",             desc = "LSP References" },
    { "<space>lI",  "<cmd>FzfLua lsp_implementations<cr>",        desc = "LSP Implementations" },
    {
      "<space>to",
      function() require 'fzf-lua'.oldfiles { include_current_session = true } end,
      desc = "FZF old files"
    },
  },
}
