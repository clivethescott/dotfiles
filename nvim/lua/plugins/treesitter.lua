return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  build = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'romgrk/nvim-treesitter-context',
      config = function()
        require 'treesitter-context'.setup {}
      end
    },
    {
      'windwp/nvim-ts-autotag',
      ft = { 'html' },
    },
    { 'nvim-treesitter/playground' }
  },
  config = function()
    local treesitter_config = require 'nvim-treesitter.configs'
    treesitter_config.setup {
      ensure_installed = { 'dockerfile', 'git_config', 'gitcommit', 'go', 'gomod', 'graphql', 'hocon', 'html',
        'javascript',
        'json', 'lua', 'make', 'markdown', 'proto', 'python', 'rust', 'scala', 'sql', 'terraform', 'toml', 'typescript',
        'vim', 'yaml' },
      auto_install = true,
      highlight = {
        enable = true,                             -- false will disable the whole extension
        additional_vim_regex_highlighting = false, -- performance may suffer if enabled
      },
      ignore_install = { "svelte" },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
        filetypes = { 'html', 'javascript', 'xml', 'markdown' },
        skip_tags = { 'br', 'img' },
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

            ['ap'] = { query = '@parameter.outer', desc = 'Select outer parameter' },

            ["ai"] = { query = "@call.outer", desc = "Select outer part of a function invoke" },
            ["ii"] = { query = "@call.inner", desc = "Select inner part of a function invoke" },

            ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inner class' },

            ['al'] = { query = '@assignment.lhs', desc = 'Select lhs assignment' },
            ['ar'] = { query = '@assignment.rhs', desc = 'Select rhs assignment' },

            ["ab"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ib"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["at"] = { query = "@trait.outer", desc = "Select outer part of a trait" },
            ["it"] = { query = "@trait.inner", desc = "Select inner part of a trait" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_previous_start = {
            ['[c'] = { query = '@class.outer', desc = 'Go to prev class' },
            ['[p'] = { query = '@parameter.outer', desc = 'Go to prev param' },
            ['[f'] = { query = '@function.outer', desc = 'Go to prev function' },
            ["[i"] = { query = "@call.outer", desc = "Prev function call start" },
          },
          goto_next_start = {
            [']c'] = { query = '@class.outer', desc = 'Go to next class' },
            [']p'] = { query = '@parameter.outer', desc = 'Go to next param' },
            [']f'] = { query = '@function.outer', desc = 'Go to next function' },
            ["]i"] = { query = "@call.outer", desc = "Prev function call end" },
          },
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
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
