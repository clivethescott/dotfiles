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
    keymap = {
      preset = 'none',
      ['<c-p>'] = { 'select_prev', 'fallback' },
      ['<c-n>'] = { 'select_next', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<cr>'] = { 'select_and_accept', 'fallback' },
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
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'lazydev', 'path', 'copilot' },
      cmdline = {
        max_items = 5, -- set cmdline = {} to disable cmdline completions
      },
      providers = {
        buffer = {
          max_items = 2,
          score_offset = -1,
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = -1,
          max_items = 3,
          async = true,
          transform_items = function(_, items) -- show Copilot in menu, default is Text
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        lsp = {
          fallbacks = { 'buffer' },
          max_items = 10,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
        snippets = {
          max_items = 3,
        },
      },
    },
    signature = { enabled = true },
    completion = {
      accept = { auto_brackets = { enabled = false }, }, -- use nvim-autopairs
      list = {
        selection = {
          preselect = true,
          auto_insert = false
        }
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
