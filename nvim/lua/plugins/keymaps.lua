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
      key_labels = {
        ["<space>"] = "SPACE",
        ["<tab>"] = "TAB",
      },
      window = {
        position = "top",
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
    -- map('n', 'k', [[v:count < 2 ? 'gk' : "m'" .. v:count .. 'k']], { expr = true })
    -- map('n', 'j', [[v:count < 2 ? 'gj' : "m'" .. v:count .. 'j']], { expr = true })

    -- Center search result
    map('n', 'n', 'nzzzv')
    map('n', 'N', 'Nzzzv')
    map('n', '#', '#zz')
    map('n', '*', '*zz')

    -- Open URI under cursor
    local open_uri = function()
      require 'helper.utils'.open_uri()
    end

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
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end

    map({ 'n', 'i' }, '<M-i>', toggle_inlay_hints)

    local wk = require 'which-key'
    wk.register({
      ["["] = {
        name = '+Previous',
        q = { "<cmd>cprevious<cr>", 'Quickfix Entry' },
        Q = { "<cmd>cNfile<cr>", 'Quickfix Entry in last file' },
        t = { prev_todo, 'TODO' },
      },
      ["]"] = {
        name = '+Next',
        t = { next_todo, 'TODO' },
        q = { "<cmd>cnext<cr>", 'Quickfix Entry' },
        Q = { "<cmd>cnfile<cr>", 'Quickfix Entry in next file' },
      },
      ["<space>"] = {
        ['['] = { ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", 'Add blank line above' },
        [']'] = { ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", 'Add blank line below' },
        p = { function() require 'telescope.builtin'.find_files() end, 'Find files in current dir' },
        d = {
          name = '+DAP',
          b = { function() require 'dap'.toggle_breakpoint() end, 'Toggle Breakpoint' },
          B = { dap_cond_breakpoint, 'Conditional Breakpoint' },
          c = { dap_commands, 'Commands' },
          d = { function() require 'dap'.repl.toggle() end, 'Toggle REPL' },
          e = { show_dap_ui, 'Show DAP UI' },
          i = { function() require 'dap'.step_into() end, 'Step In' },
          I = { function() require 'dap'.step_out() end, 'Step Out' },
          l = { dap_list_breakpoints, 'List Breakpoints' },
          L = { function() require 'dap'.clear_breakpoints() end, 'Clear Breakpoints' },
          o = { function() require 'dap'.step_over() end, 'Step Over' },
          q = { dap_terminate, 'Terminate' },
          r = { function() require 'dap'.continue() end, 'Continue' },
          t = { go_debug_test, 'Debug Go Test' },
          x = { dap_terminate, 'Terminate' },
        },
        e = {
          name = '+Trouble Diagnostics',
          d = { '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics' },
          e = { '<cmd>Trouble diagnostics toggle<cr>', 'Toggle Window' },
          l = {
            name = '+LSP',
            r = { '<cmd>Trouble lsp_references<cr>', 'References' },
            i = { '<cmd>Trouble lsp_implementations<cr>', 'References' },
            -- TODO: configure incoming/outgoing references type def or maybe vim LSP itself?
          },
          q = { '<cmd>Trouble qflist toggle<cr>', 'Quickfix Toggle' },
          r = { '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', 'LSP References' },
          t = { '<cmd>TodoTrouble<cr>', 'TODOs' },
          -- w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
        },
        f = {
          name = '+Oil',
          f    = { '<cmd>Oil --float ~/.config/nvim/lua/plugins<cr>', 'Open Oil In Plugins dir' },
          h    = { function() require 'oil.actions'.toggle_hidden.callback() end, 'Toggle Hidden files' },
          H    = { function() require 'oil.actions'.show_help.callback() end, 'Show Help' },
          o    = { function() require 'oil.actions'.open_external.callback() end, 'Open External' },
          p    = { function() require 'oil.actions'.preview.callback() end, 'Show Preview' },
          r    = { function() require 'oil.actions'.refresh.callback() end, 'Refresh' },
          s    = { function() require 'oil.actions'.change_sort.callback() end, 'Change sort' },
          v    = { function() require 'oil.actions'.select_vsplit.callback() end, 'Open vsplit' },
        },
        g = {
          '+Git',
          d = {
            name = '+Diffview',
            h = { '<cmd>DiffviewFileHistory %<cr>', 'Current file History' },
            H = { '<cmd>DiffviewFileHistory<cr>', 'Branch History' },
            o = { '<cmd>DiffviewOpen<cr>', 'Git diff' },
            q = { '<cmd>DiffviewClose<cr>', 'Close diff' },
          },
          g = { '<cmd>Telescope git_branches<cr>', 'Branches' },
          l = { '<cmd>Telescope git_bcommits<cr>', 'Buffer Commits' },
          L = { '<cmd>Telescope git_commits<cr>', 'All Commits' },
        },
        m = {
          name = '+Metals',
          c = { function() require 'telescope'.extensions.metals.commands() end, 'Commands' },
          d = { function() require 'metals'.goto_super_method() end, 'Go To Super Method' },
          k = { function() require 'metals'.hover_worksheet() end, 'Hover Worksheet' },
          n = { function() require 'metals'.new_scala_file() end, 'New File' },
          s = { function() require 'metals'.switch_bsp() end, 'Switch BSP Server' },
          t = {
            name = 'TVP',
            o = { function() require 'metals.tvp'.reveal_in_tree() end, 'Reveal In Tree' },
            t = { function() require 'metals.tvp'.toggle_tree_view() end, 'Toggle Tree' },
          },
        },
        o = {
          name = '+Open Window',
          d = { '<cmd>DiffviewOpen<cr>', 'Diffview' },
          f = { toggle_winbar, 'Winbar' },
          g = { '<cmd>Neogit kind=replace<cr>', 'Neogit' },
          l = { '<cmd>Lazy<cr>', 'Lazy Plugin Mgr' },
          L = { '<cmd>Lazy sync<cr>', 'Lazy Sync' },
          m = { '<cmd>Mason<cr>', 'Mason LSP Server Mgr' },
          o = { '<cmd>Oil --float<cr>', 'Oil' },
          u = { '<cmd>UndotreeToggle<cr>', 'UndoTree' },
        },
        s = {
          name = '+Session',
          s = { '<cmd>SessionSave<cr>', 'Save session for dir' },
          r = { '<cmd>SessionRestore<cr>', 'Restore session for dir' },
          R = {
            function()
              -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#workaround-when-using-rmagattiauto-session
              local api = require('nvim-tree.api')
              local view = require('nvim-tree.view')

              if not view.is_visible() then
                api.tree.open()
              end
              require 'auto-session'.AutoSessionRestore()
            end,
            'Restore session for dir' },
          l = { function() require("auto-session.session-lens").search_session() end, 'List sessions' },
        },
        t = {
          name = '+Telescope',
          c = { '<cmd>Telescope commands<cr>', 'Commands' },
          f = { '<cmd>Telescope live_grep_args<cr>', 'Live grep args' },
          F = { function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end, 'Live grep cword' },
          -- f = { '<cmd>Telescope live_grep<cr>', 'Live grep' },
          -- F = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer fuzzy find' },
          h = { '<cmd>Telescope help_tags<cr>', 'Help tags' },
          j = { '<cmd>Telescope jumplist<cr>', 'Jump list' },
          k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
          l = { '<cmd>Telescope resume<cr>', 'Resume last picker' },
          m = { '<cmd>Telescope marks<cr>', 'Marks' },
          o = { '<cmd>Telescope oldfiles<cr>', 'Old Files' },
          q = { '<cmd>Telescope quickfix<cr>', 'Quickfix List' },
          r = { '<cmd>Telescope registers<cr>', 'Registers' },
          g = { '<cmd>TodoTelescope<cr>', 'TODOs' },
        },
        w = {
          name = '+Resize Splits',
          h = { '5<c-w><', 'Resize left' },
          l = { '5<c-w>>', 'Resize right' },
          j = { '5<c-w>-', 'Resize down' },
          k = { '5<c-w>+', 'Resize up' },
        }
      },
      ["<leader>"] = {
        ['!'] = { '<cmd>Oil --float<cr>', 'Find File In Oil' },
        ['1'] = { '<cmd>Oil --float<cr>', 'Toggle Oil' },
        ['2'] = { find_nvim_files, 'Find nvim config files' },
        ['3'] = { grep_nvim_files, 'Live grep nvim config files' },
        ['4'] = { grep_zsh_files, 'Find zsh config files' },
        ['5'] = { find_dotfiles, 'Find dot files' },
        g = {
          name = '+GoTo',
          f = { '<cmd>AlternateFile<cr>', 'Alternate file' },
          i = { '<cmd>GoImports<cr>', 'Go Imports' },
          x = { open_uri, 'URI at cursor' },
        },
        m = { '<cmd>silent! nohls<cr>', 'Clear search highlight' },
        s = { edit_snippets, 'Edit LuaSnippets' },
        t = { '<cmd>tabclose<cr>', 'Close tab' },
      },
      ['gp'] = { ':b#<cr>', 'Alternate buffer' },
    })
  end,
}
