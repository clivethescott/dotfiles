local M = {}

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}
M.project_files = function()
  local opts = {
    hidden = true,
    no_ignore = false,
    show_untracked = true
  }

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  local telescope = require 'telescope.builtin'
  if is_inside_work_tree[cwd] then
    telescope.git_files(opts)
  else
    telescope.find_files(opts)
  end
end

return {
  "folke/which-key.nvim",
  lazy = false,
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup({
      plugins = {
        presets = {
          operators = false,
          motions = false,
        },
      },
    })

    local default_opts = { silent = true, noremap = true }
    local map = function(mode, lhs, rhs, opts)
      if opts then
        vim.tbl_extend('keep', opts, default_opts)
      else
        opts = default_opts
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Dealing with word wrap on long lines
    map('n', 'k', [[v:count < 2 ? 'gk' : "m'" .. v:count .. 'k']], { expr = true })
    map('n', 'j', [[v:count < 2 ? 'gj' : "m'" .. v:count .. 'j']], { expr = true })

    -- Center search result
    map('n', 'n', 'nzzzv')
    map('n', 'N', 'Nzzzv')
    map('n', '#', '#zz')
    map('n', '*', '*zz')

    -- Split movements
    -- Replace with tmux-navigator

    -- Resize v-splits
    map('n', '<space>wh', '5<c-w><')
    map('n', '<space>wk', '5<c-w>+')
    map('n', '<space>wl', '5<c-w>>')
    map('n', '<space>wj', '5<c-w>-')

    -- Saving
    map('n', '<c-s>', ':update<cr>')
    map('i', '<c-s>', '<esc>:update<cr>')

    -- Jump to exact mark position either way
    -- Disabled not recognised by which-key
    -- map('n', "'", "`")

    -- Faster way to quit
    map('n', 'Q', ':q<cr>')

    -- Faster way to yank line
    map('n', 'Y', 'yy')

    -- Shouldn't be using these anyway
    map('n', '<left>', '<nop>')
    map('v', '<left>', '<nop>')
    map('n', '<right>', '<nop>')
    map('v', '<right>', '<nop>')
    map('n', '<down>', '<nop>')
    map('v', '<down>', '<nop>')
    map('n', '<up>', '<nop>')
    map('v', '<up>', '<nop>')

    -- Keep selection after visual indent/outdent
    map('v', '<', '<gv')
    map('v', '>', '>gv')


    map('n', '<M-[>', '<C-o>')
    map('n', '<M-]>', '<C-i>')
    local toggle_winbar = function()
      if vim.o.winbar == "" then
        vim.o.winbar = "%{%v:lua.require'helper.utils'.nvim_winbar()%}"
      else
        vim.o.winbar = ""
      end
    end

    local home = os.getenv('HOME')
    local minimal_ignore = home .. '/.gitignore_minimal'
    -- Quickly add empty lines
    -- https://github.com/mhinz/vim-galore#quickly-add-empty-lines=
    map('n', '<space>[', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
    map('n', '<space>]', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>')

    -- Telescope mappings
    map('n', '<c-e>', function() require 'telescope.builtin'.buffers { sort_lastused = true } end)
    -- Use git_files if in git dir, else use find_files
    map('n', '<c-p>', M.project_files)
    map('n', 'π', function()
      require 'telescope.builtin'.find_files {
        find_command = { "fd", "--type", "f", "--hidden", "--max-depth", "10", "--strip-cwd-prefix", "--ignore-file", minimal_ignore },
        no_ignore = true,
        no_ignore_parent = true,
        hidden = true,
      }
    end)
    map('n', 'Ï', function() require 'telescope.builtin'.live_grep() end)
    map('n', 'ƒ', function() require 'telescope.builtin'.current_buffer_fuzzy_find() end)

    local find_nvim_files = function()
      require 'telescope.builtin'.find_files {
        cwd = '~/.config/nvim'
      }
    end
    local find_dotfiles = function()
      require 'telescope.builtin'.find_files {
        cwd = '~/dotfiles'
      }
    end
    local grep_nvim_files = function()
      require 'telescope.builtin'.live_grep {
        cwd = '~/.config/nvim',
        follow = true,
      }
    end
    local grep_zsh_files = function()
      require 'telescope.builtin'.find_files {
        cwd = '~/.config/zsh',
        follow = true,
      }
    end

    -- DAP mappings
    local dap_commands = function()
      require 'telescope'.extensions.dap.commands {}
    end
    local dap_terminate = function()
      require 'dap'.terminate({}, {})
    end
    local dap_cond_breakpoint = function()
      require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end
    local dap_list_breakpoints = function()
      require 'telescope'.extensions.dap.list_breakpoints {}
    end
    local show_dap_ui = function()
      require 'dapui'.eval('', {})
    end
    local go_debug_test = function()
      require 'dap-go'.debug_test()
    end


    -- Luasnip Mappings
    map({ 'i', 's' }, '<C-j>', function()
      local ls = require 'luasnip'
      if ls.jumpable(1) then
        ls.jump(1)
      end
    end)
    map({ 'i', 's' }, '<C-k>', function()
      local ls = require 'luasnip'
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end)
    -- minimal choice change, same as when using vim.ui.select below
    map({ 'i' }, '<C-y>', function()
      require 'luasnip'.expand()
    end)
    -- Luasnip choice selection using vim.ui.select
    map({ 'i' }, '<C-e>', function()
      local ls = require 'luasnip'
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)
    local edit_snippets      = function()
      require("luasnip.loaders").edit_snippet_files {
        format = function(file, source_name)
          if source_name == 'lua' then
            return '$Config/' .. vim.fn.fnamemodify(file, ':t')
          else
            -- ignore plugin managed sources in the selection
            return nil
          end
        end,
        extend = function(ft, paths)
          if #paths == 0 then
            local luasnippets_dir = vim.fn.stdpath('config') .. '/luasnippets'
            return {
              { "$Config/" .. ft .. ".lua", string.format("%s/%s.lua", luasnippets_dir, ft) }
            }
          end
          return {}
        end
      }
    end

    local prev_todo          = function()
      require 'todo-comments'.jump_prev()
    end
    local next_todo          = function()
      require 'todo-comments'.jump_next()
    end

    local toggle_inlay_hints = function()
      local opts = {}
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(opts))
    end

    map({ 'n', 'i' }, '<M-i>', toggle_inlay_hints)

    local wk = require 'which-key'
    wk.add({
      {
        group = '+Previous',
        { "[q", "<cmd>cprevious<cr>", desc = 'Quickfix Entry' },
        { "[Q", "<cmd>cNfile<cr>",    desc = 'Quickfix Entry in last file' },
        { "[t", prev_todo,            desc = 'TODO' },
      },
      {
        group = '+Next',
        { "]t", next_todo,         desc = 'TODO' },
        { "]q", "<cmd>cnext<cr>",  desc = 'Quickfix Entry' },
        { "]Q", "<cmd>cnfile<cr>", desc = 'Quickfix Entry in next file' },
      },
      { '<space>[', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[",       desc = 'Add blank line above' },
      { '<space>]', ":<c-u>put =repeat(nr2char(10), v:count1)<cr>",          desc = 'Add blank line below' },
      { '<space>p', function() require 'telescope.builtin'.find_files() end, desc = 'Find files in current dir' },
      {
        group = '+DAP',
        { '<space>db', function() require 'dap'.toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
        { '<space>dB', dap_cond_breakpoint,                              desc = 'Conditional Breakpoint' },
        { '<space>dc', dap_commands,                                     desc = 'Commands' },
        { '<space>dd', function() require 'dap'.repl.toggle() end,       desc = 'Toggle REPL' },
        { '<space>de', show_dap_ui,                                      desc = 'Show DAP UI' },
        { '<space>di', function() require 'dap'.step_into() end,         desc = 'Step In' },
        { '<space>dI', function() require 'dap'.step_out() end,          desc = 'Step Out' },
        { '<space>dl', dap_list_breakpoints,                             desc = 'List Breakpoints' },
        { '<space>dL', function() require 'dap'.clear_breakpoints() end, desc = 'Clear Breakpoints' },
        { '<space>do', function() require 'dap'.step_over() end,         desc = 'Step Over' },
        { '<space>dq', dap_terminate,                                    desc = 'Terminate' },
        { '<space>dr', function() require 'dap'.continue() end,          desc = 'Continue' },
        { '<space>dt', go_debug_test,                                    desc = 'Debug Go Test' },
        { '<space>dx', dap_terminate,                                    desc = 'Terminate' },
      },
      {
        group = '+Trouble Diagnostics',
        { '<space>ed',  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = 'Buffer Diagnostics' },
        { '<space>ee',  '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'Toggle Window' },
        { '<space>elr', '<cmd>Trouble lsp_references<cr>',                            desc = 'References' },
        -- TODO: configure incoming/outgoing references type def or maybe vim LSP itself?
        { '<space>eli', '<cmd>Trouble lsp_implementations<cr>',                       desc = 'References' },
        { '<space>eq',  '<cmd>Trouble qflist toggle<cr>',                             desc = 'Quickfix Toggle' },
        { '<space>er',  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP References' },
        { '<space>et',  '<cmd>TodoTrouble<cr>',                                       desc = 'TODOs' },
        -- w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
      },
      {
        group = '+Oil',
        { '<space>ff', '<cmd>Oil --float ~/.config/nvim/lua/plugins<cr>',             desc = 'Open Oil In Plugins dir' },
        { '<space>fh', function() require 'oil.actions'.toggle_hidden.callback() end, desc = 'Toggle Hidden files' },
        { '<space>fH', function() require 'oil.actions'.show_help.callback() end,     desc = 'Show Help' },
        { '<space>fo', function() require 'oil.actions'.open_external.callback() end, desc = 'Open External' },
        { '<space>fp', function() require 'oil.actions'.preview.callback() end,       desc = 'Show Preview' },
        { '<space>fr', function() require 'oil.actions'.refresh.callback() end,       desc = 'Refresh' },
        { '<space>fs', function() require 'oil.actions'.change_sort.callback() end,   desc = 'Change sort' },
        { '<space>fv', function() require 'oil.actions'.select_vsplit.callback() end, desc = 'Open vsplit' },
      },
      {
        group = '+Diffview',
        { '<space>gDh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Current file History' },
        { '<space>gDH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Branch History' },
        { '<space>gDo', '<cmd>DiffviewOpen<cr>',          desc = 'Git diff' },
        { '<space>gDq', '<cmd>DiffviewClose<cr>',         desc = 'Close diff' },
      },
      {
        group = '+Git',
        { '<space>gg', '<cmd>Telescope git_branches<cr>', desc = 'Branches' },
        { '<space>gl', '<cmd>Telescope git_bcommits<cr>', desc = 'Buffer Commits' },
        { '<space>gL', '<cmd>Telescope git_commits<cr>',  desc = 'All Commits' },
        { '<space>go', '<cmd>Neogit kind=replace<cr>',    desc = 'Neogit' },
      },
      {
        group = '+Metals',
        {
          '<space>mc',
          function() require 'telescope'.extensions.metals.commands() end,
          desc = 'Commands'
        },
        {
          '<space>md',
          function() require 'metals'.goto_super_method() end,
          desc = 'Go To Super Method'
        },
        {
          '<space>mk',
          function() require 'metals'.hover_worksheet() end,
          desc = 'Hover Worksheet'
        },
        {
          '<space>mn',
          function() require 'metals'.new_scala_file() end,
          desc = 'New File'
        },
        {
          '<space>ms',
          function() require 'metals'.switch_bsp() end,
          desc = 'Switch BSP Server'
        },
        {
          '<space>mto',
          function() require 'metals.tvp'.reveal_in_tree() end,
          desc = 'Reveal In Tree'
        },
        {
          '<space>mtt',
          function() require 'metals.tvp'.toggle_tree_view() end,
          desc = 'Toggle Tree'
        },
      },
      {
        group = '+Open Window',
        { '<space>od', '<cmd>DiffviewOpen<cr>',   desc = 'Diffview' },
        { '<space>of', toggle_winbar,             desc = 'Winbar' },
        { '<space>og', '<cmd>Neogit',             desc = 'Neogit' },
        { '<space>on', '<cmd>Neogit',             desc = 'Neogit' },
        { '<space>ol', '<cmd>Lazy<cr>',           desc = 'Lazy Plugin Mgr' },
        { '<space>oL', '<cmd>Lazy sync<cr>',      desc = 'Lazy Sync' },
        { '<space>om', '<cmd>Mason<cr>',          desc = 'Mason LSP Server Mgr' },
        { '<space>oo', '<cmd>Oil --float<cr>',    desc = 'Oil' },
        { '<space>ou', '<cmd>UndotreeToggle<cr>', desc = 'UndoTree' },
      },
      {
        group = '+Telescope',
        { '<space>tc', '<cmd>Telescope commands<cr>',       desc = 'Commands' },
        { '<space>tf', '<cmd>Telescope live_grep_args<cr>', desc = 'Live grep args' },
        {
          '<space>tF',
          function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end,
          desc = 'Live grep cword'
        },
        -- f = { '<cmd>Telescope live_grep<cr>', 'Live grep' },
        -- F = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer fuzzy find' },
        { '<space>th', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
        { '<space>tj', '<cmd>Telescope jumplist<cr>',  desc = 'Jump list' },
        { '<space>tk', '<cmd>Telescope keymaps<cr>',   desc = 'Keymaps' },
        { '<space>tl', '<cmd>Telescope resume<cr>',    desc = 'Resume last picker' },
        { '<space>tm', '<cmd>Telescope marks<cr>',     desc = 'Marks' },
        { '<space>to', '<cmd>Telescope oldfiles<cr>',  desc = 'Old Files' },
        { '<space>tq', '<cmd>Telescope quickfix<cr>',  desc = 'Quickfix List' },
        { '<space>tr', '<cmd>Telescope registers<cr>', desc = 'Registers' },
        { '<space>tg', '<cmd>TodoTelescope<cr>',       desc = 'TODOs' },
      },
      {
        group = '+Resize Splits',
        { '<space>wh', '5<c-w><', desc = 'Resize left' },
        { '<space>wl', '5<c-w>>', desc = 'Resize right' },
        { '<space>wj', '5<c-w>-', desc = 'Resize down' },
        { '<space>wk', '5<c-w>+', desc = 'Resize up' },
      },
      {
        group = '+Locate file',
        { '<leader>!', '<cmd>Oil --float<cr>',   desc = 'Find File In Oil' },
        { '<leader>1', '<cmd>Oil --float<cr>',   desc = 'Toggle Oil' },
        { '<leader>2', find_nvim_files,          desc = 'Find nvim config files' },
        { '<leader>3', grep_nvim_files,          desc = 'Live grep nvim config files' },
        { '<leader>4', grep_zsh_files,           desc = 'Find zsh config files' },
        { '<leader>5', find_dotfiles,            desc = 'Find dot files' },
        { '<leader>m', '<cmd>silent! nohls<cr>', desc = 'Clear search highlight' },
        { '<leader>s', edit_snippets,            desc = 'Edit LuaSnippets' },
        { '<leader>t', '<cmd>tabclose<cr>',      desc = 'Close tab' },
      },
      {
        group = '+Obsidian',
        { '<space>np',  '<cmd>ObsidianQuickSwitch<cr>',   desc = 'Open/Switch Note' },
        { '<space>nn',  '<cmd>ObsidianQuickSwitch<cr>',   desc = 'Open/Switch Note' },
        { '<space>ne',  '<cmd>ObsidianNew<cr>',           desc = 'New Note' },
        { '<space>nov', '<cmd>ObsidianFollowLink vsplit', desc = 'Open Link in vsplit' },
        { '<space>nos', '<cmd>ObsidianFollowLink hsplit', desc = 'Open Link in hsplit' },
        { '<space>nt',  '<cmd>ObsidianTOC',               desc = 'Show TOC' },
      },
      {
        group = '+Session',
        {
          '<space>so',
          function() require 'persistence'.load() end,
          desc = 'Load session for current directory'
        },
        { '<space>se', function() require 'persistence'.select() end, desc = 'Select session' },
        {
          '<space>sl',
          function() require 'persistence'.load({ last = true }) end,
          desc = 'Load last session'
        },
        {
          '<space>sq',
          function() require 'persistence'.stop() end,
          desc = 'Stop session tracking'
        },
      },
      { 'gp',       ':b#<cr>',                       desc = 'Alternate buffer' },
      { 'gs',       '<cmd>Neogit kind=floating<cr>', desc = 'Git status' },
      { '<space>y', ':%y<cr>',                       desc = 'Yank buffer' },
    })
  end,
}
