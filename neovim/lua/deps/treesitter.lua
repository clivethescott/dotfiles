return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  build = function()
    pcall(require('nvim-treesitter.install').update { with_sync = false })
  end,
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects', event = 'InsertEnter' },
    {
      'nvim-treesitter/nvim-treesitter-context',
      keys = {
        { '[j', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'Jump to TS context' }
      }
    }
  },
  init = function()
    -- https://mise.jdx.dev/mise-cookbook/neovim.html#code-highlight-for-run-commands
    require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
      local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
      local filename = vim.fn.fnamemodify(filepath, ":t")
      return string.match(filename, ".*mise.*%.toml$")
    end, { force = true, all = false })
  end,
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
          enable = false,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          -- include_surrounding_whitespace = function(opts)
          -- return opts.query and string.find(opts.query, "outer") or false
          -- end,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            -- Managed by mini.ai custom_textobjects
            ['af'] = { query = '@function.outer', desc = 'Select outer function' },
            ['if'] = { query = '@function.inner', desc = 'Select inner function' },

            -- ['ag'] = { query = '@function.params', desc = 'Select outer parameter' },
            -- ['aG'] = { query = '@function.name', desc = 'Select function name' },
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
