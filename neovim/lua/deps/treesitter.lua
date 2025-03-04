return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  build = function()
    pcall(require('nvim-treesitter.install').update { with_sync = false })
  end,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'InsertEnter' },
  },
  config = function()
    local treesitter_config = require 'nvim-treesitter.configs'
    treesitter_config.setup {
      ensure_installed = { 'dockerfile', 'git_config', 'gitcommit', 'graphql', 'hocon', 'html',
        'http', 'properties', 'json', 'lua', 'markdown', 'markdown_inline', 'python', 'rust', 'scala', 'sql', 'toml',
        'vim', 'yaml', 'fish', 'hurl' },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,                             -- false will disable the whole extension
        additional_vim_regex_highlighting = false, -- performance may suffer if enabled
      },
      ignore_install = { "svelte" },
      indent = {
        enable = true,
        disable = { 'ocaml' } -- strange issue where let is indent (set in :h indentkeys)
      },
      autotag = {
        enable = true,
        filetypes = { 'html', 'javascript', 'xml', 'markdown' },
        skip_tags = { 'br', 'img' },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-space>",
          node_incremental = "<M-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          -- include_surrounding_whitespace = function(opts)
          -- return opts.query and string.find(opts.query, "outer") or false
          -- end,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = 'Select outer function' },
            ['if'] = { query = '@function.inner', desc = 'Select inner function' },

            ['am'] = { query = '@function.outer', desc = 'Select outer function' },
            ['im'] = { query = '@function.inner', desc = 'Select inner function' },

            ['aV'] = { query = '@val.outer', desc = 'Select outer val' },
            ['av'] = { query = '@val.right', desc = 'Select val expression' },

            ['ag'] = { query = '@function.params', desc = 'Select outer parameter' },
            ['aG'] = { query = '@function.name', desc = 'Select function name' },


            ["aj"] = { query = "@json.outer", desc = "Select outer JSON" },

            ["ai"] = { query = "@call.outer", desc = "Select outer part of a function invoke" },
            ["ii"] = { query = "@call.inner", desc = "Select inner part of a function invoke" },

            ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inner class' },

            ['as'] = { query = '@struct.outer', desc = 'Select outer struct' },
            ['aS'] = { query = '@impl.outer', desc = 'Select outer impl' },
            ['is'] = { query = '@struct.inner', desc = 'Select inner struct' },
            ['iS'] = { query = '@impl.inner', desc = 'Select inner impl' },

            ['al'] = { query = '@assignment.lhs', desc = 'Select lhs assignment' },
            ['ar'] = { query = '@assignment.rhs', desc = 'Select rhs assignment' },

            ["ab"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ib"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["ay"] = { query = "@for.outer", desc = "Outer for expression" },
            ["iy"] = { query = "@for.inner", desc = "Inner for expression" },

            ["ao"] = { query = "@object.outer", desc = "Outer object" },
            ["io"] = { query = "@object.inner", desc = "Inner object" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_previous_start = {
            ['[p'] = { query = '@parameter.inner', desc = 'Go to prev param' },

            ['[P'] = { query = '@function.params', desc = 'Go to prev params' },
            ['[f'] = { query = '@function.outer', desc = 'Go to prev function' },
            ['[F'] = { query = '@function.inner', desc = 'Go to prev function inner' },
            -- ["[i"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[y"] = { query = "@for.outer", desc = "Previous for expression" },
            ["[s"] = { query = "@struct.outer", desc = "Previous struct" },
            ["[S"] = { query = "@impl.outer", desc = "Previous struct impl" },
          },
          goto_previous_end = {
            ['[a'] = { query = '@assignment.lhs', desc = 'Goto lhs assignment' },
          },
          goto_next_end = {
            [']a'] = { query = '@assignment.rhs', desc = 'Goto rhs assignment' },
          },
          goto_next_start = {
            [']p'] = { query = '@parameter.inner', desc = 'Go to next param' },
            [']f'] = { query = '@function.outer', desc = 'Go to next function' },
            [']F'] = { query = '@function.inner', desc = 'Go to next function inner' },
            -- ["]i"] = { query = "@call.outer", desc = "Prev function call end" },
            ["]y"] = { query = "@for.outer", desc = "Next for expression" },
            ["]s"] = { query = "@struct.outer", desc = "Next struct" },
            ["]S"] = { query = "@impl.outer", desc = "Next struct impl" },
          },
        },
        rainbow = {
          enable = false,
          extended_mode = true,
          max_file_lines = 1000,
        },
      },
      query_linter = {
        enable = false,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      playground = {
        enable = true,
      },
    }
  end
}
