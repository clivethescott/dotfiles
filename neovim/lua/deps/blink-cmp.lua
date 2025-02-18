return {
  "Saghen/blink.cmp",
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  event = 'VeryLazy',
  -- use a release tag to download pre-built binaries
  opts = {
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'enter',
        ['<tab>'] = { 'select_next' },
        ['<s-tab>'] = { 'select_prev' },
        ['<C-y>'] = { 'select_and_accept' },
      },
      sources = {
        max_items = 5, -- set cmdline = {} to disable cmdline completions
      },
    },
    keymap = {
      preset = 'none',
      ['<c-p>'] = { 'show', 'select_prev', 'fallback' },
      ['<c-n>'] = { 'show', 'select_next', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<cr>'] = { 'select_and_accept', 'fallback' },
      ['<c-j>'] = { 'snippet_forward', 'fallback' },
      ['<c-k>'] = { 'snippet_backward', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'markdown', 'lazydev', 'path' },
      providers = {
        buffer = {
          max_items = 2,
          score_offset = -1,
        },
        lsp = {
          fallbacks = { 'buffer' },
          max_items = 20,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
        snippets = {
          max_items = 3,
        },
      },
    },
    signature = { enabled = true },
    completion = {
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = false }, }, -- use nvim-autopairs
      list = {
        selection = {
          preselect = true,
          auto_insert = false
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        treesitter_highlighting = true, -- disable if perf issues
        window = {
          min_width = 40,
        }
      },
      menu = {
        auto_show = false,
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
