return {
  "Saghen/blink.cmp",
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  -- use a release tag to download pre-built binaries
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    keymap = {
      preset = 'none',
      ['<c-p>'] = { 'select_prev', 'fallback' },
      ['<c-n>'] = { 'select_next', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<cr>'] = { 'accept', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<c-j>'] = { 'snippet_forward', 'fallback' },
      ['<c-k>'] = { 'snippet_backward', 'fallback' },
      ['<c-g>'] = { function() require 'blink.cmp'.show_documentation() end },
      cmdline = {
        preset = 'enter',
        ['<tab>'] = { 'accept' },
        ['<cr>'] = { 'fallback' }, -- get out of cmdline on enter
      }
    },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'path', },
      providers = {
        lsp = {
          fallbacks = { 'buffer' },
        },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = false }, }, -- use nvim-autopairs
      -- trigger = { signature_help = { enabled = false } },
      list = { selection = 'preselect' },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 2000,
        treesitter_highlighting = true, -- disable if perf issues
        window = {
          min_width = 40,
        }
      },
      menu = {
        auto_show = true,
        -- nvim-cmp style menu
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" }
          },
        }
      },
    },
  }
}
