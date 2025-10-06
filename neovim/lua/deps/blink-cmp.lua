return {
  "Saghen/blink.cmp",
  build = "cargo build --release",
  dependencies = {
    'rafamadriz/friendly-snippets',
    'Kaiser-Yang/blink-cmp-avante'
  },
  event = 'VeryLazy',
  -- use a release tag to download pre-built binaries
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    cmdline = {
      enabled = false,
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
      ['<C-y>'] = { 'select_and_accept',
        function() -- sidekick next edit suggestion
          return require("sidekick").apply()
        end, 'fallback' },
      ['<cr>'] = { 'select_and_accept', 'fallback' },
      ['<c-j>'] = { 'snippet_forward', 'fallback' },
      ['<c-f>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-b>'] = { 'scroll_documentation_down', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'omni', 'markdown', 'lazydev', 'path', 'avante' },
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
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
            -- options for blink-cmp-avante
          }
        }
      },
    },
    signature = { enabled = true },
    completion = {
      ghost_text = { enabled = false },
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
        auto_show = true,
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
  }
}
