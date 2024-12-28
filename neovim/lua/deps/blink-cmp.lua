return {
  "Saghen/blink.cmp",
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  -- use a release tag to download pre-built binaries
  opts = {
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    keymap = {
      preset = 'none',
      ['<c-p>'] = { 'select_prev', 'fallback' },
      ['<c-n>'] = { 'select_next', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<c-j>'] = { 'snippet_forward', 'fallback' },
      ['<c-k>'] = { 'snippet_backward', 'fallback' },
      ['<c-f>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-b>'] = { 'scroll_documentation_down', 'fallback' },
      cmdline = {
        preset = 'enter',
        ['<tab>'] = { 'select_next' },
        ['<s-tab>'] = { 'select_prev' },
        ['<C-y>'] = { 'select_and_accept' },
      }
    },
    appearance = {

    },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'lazydev', 'path', },
      providers = {
        lsp = {
          fallbacks = { 'buffer' },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = false }, }, -- use nvim-autopairs
      -- trigger = { signature_help = { enabled = false } },
      list = {
        selection = function(ctx)
          return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
        end
      },
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
            { "kind_icon", "kind",              gap = 1 }
          },
        }
      },
    },
  }
}
