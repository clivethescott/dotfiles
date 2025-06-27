return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  build = function()
    pcall(require('nvim-treesitter.install').update { with_sync = false })
  end,
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      event = 'BufReadPost',
      keys = {
        { '[h', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'Jump to TS context' }
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
        enable = true,          -- false will disable the whole extension
        disable = function(lang, bufnr) -- Disable in large JSON buffers
          return lang == "json" and vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
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
