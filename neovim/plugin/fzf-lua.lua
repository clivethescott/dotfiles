if vim.g.use_picker ~= 'fzf-lua' then return end

local ignore_files = { "^%.metals", "^%.scala", "^Gemfile.lock", "^%.archived", "fast.lua" }

vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/nvim-tree/nvim-web-devicons', version = 'master' } })
  vim.pack.add({ { src = 'https://github.com/ibhagwan/fzf-lua' } })

  local actions = require("fzf-lua").actions
  local config = require 'fzf-lua'.config
  -- Quickfix
  config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
  config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
  config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
  config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
  config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
  config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
  require("fzf-lua").setup({
    'default',
    -- "skim",
    -- fzf_bin = 'sk',
    fzf_colors = true,
    defaults = {
      formatter = "path.filename_first",
      -- formatter = "path.dirname_first",
    },
    fzf_opts = {
      -- ["--layout"] = "default", -- prompt at bottom
      ["--cycle"] = true,
      -- ["--algo"] = "frizbee",
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
        ["alt-h"]   = actions.toggle_hidden,
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
    lsp = {
      code_actions = {
        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
      },
    },
    winopts = {
      height = 0.9,
      width = 0.9,
      preview = {
        default = 'bat',
        hidden = true,
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
    function() require("fzf-lua").files { cwd = '~/.config/nvim', file_ignore_patterns = ignore_files } end,
    { silent = true, desc = "Nvim files" })

  vim.keymap.set("n", "<leader>3",
    function() require("fzf-lua").live_grep { cwd = '~/.config/nvim', file_ignore_patterns = ignore_files  } end,
    { silent = true, desc = "Nvim files" })

  local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/site/pack/core/opt')
  vim.keymap.set("n", "<leader>4",
    function() require("fzf-lua").files { cwd = plugins_dir } end,
    { silent = true, desc = "Nvim plugin files" })
  vim.keymap.set("n", "<leader>5",
    function() require("fzf-lua").live_grep { cwd = plugins_dir } end,
    { silent = true, desc = "Nvim plugin grep" })

  vim.keymap.set("n", "<space>ho",
    function() require("fzf-lua").files { cwd = '~/Code/HTTP' } end,
    { silent = true, desc = "HTTP files" })

  vim.keymap.set("n", "<c-p>", function() require("fzf-lua").files({ file_ignore_patterns = ignore_files }) end,
    { desc = "FZF files" })
  vim.keymap.set("n", "<M-p>", function() require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") }) end,
    { desc = "FZF files (lwd)" })
  vim.keymap.set("n", "<c-e>", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
  vim.keymap.set("n", "<space>tl", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
  vim.keymap.set("n", "<space>tq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix" })
  vim.keymap.set("n", "<space>tf", function() require 'fzf-lua'.live_grep({ file_ignore_patterns = ignore_files }) end,
    { desc = "Live grep" })
  vim.keymap.set("n", "<space>tF", "<cmd>FzfLua grep_cWORD<cr>", { desc = "Grep cword" })
  vim.keymap.set("n", "<space>gb", "<cmd>FzfLua git_branches<cr>", { desc = "Git Branches" })
  vim.keymap.set("n", "<space>tc", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
  vim.keymap.set("n", "<space>tC", "<cmd>FzfLua command_history<cr>", { desc = "Commands History" })
  vim.keymap.set("n", "<space>th", "<cmd>FzfLua helptags<cr>", { desc = "Helptags" })
  vim.keymap.set("n", "<space>tH", "<cmd>FzfLua highlights<cr>", { desc = "Highlights" })
  vim.keymap.set("n", "<space>tt", "<cmd>FzfLua<cr>", { desc = "Tagstack" })
  vim.keymap.set("n", "<leader>z", "<cmd>FzfLua spell_suggest<cr>", { desc = "Spell Suggest" })
  vim.keymap.set("n", "<space>tm", "<cmd>FzfLua marks<cr>", { desc = "Marks" })
  vim.keymap.set("n", "<space>tr", "<cmd>FzfLua registers<cr>", { desc = "Registers" })
  vim.keymap.set("n", "<space>tb", "<cmd>FzfLua lines<cr>", { desc = "Open Buffers lines" })
  vim.keymap.set("n", "<space>tz", "<cmd>FzfLua zoxide<cr>", { desc = "Zoxide" })
  vim.keymap.set("n", "<space>lw", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "LSP workspace symbols" })
  vim.keymap.set("n", "<space>ld", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Diagnostics" })
  vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references<cr>", { desc = "LSP References" })
  vim.keymap.set("n", "<space>lI", "<cmd>FzfLua lsp_implementations<cr>", { desc = "LSP Implementations" })
  vim.keymap.set("n", "<space>to", function() require 'fzf-lua'.oldfiles { include_current_session = true } end,
    { desc = "FZF old files" })
end)
