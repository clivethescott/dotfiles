vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/folke/lazydev.nvim' } })
  vim.pack.add({ { src = 'https://github.com/rafamadriz/friendly-snippets', version = 'main' } })
  vim.pack.add({ { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('1.*') } })

  -- local cargo_bin = vim.fs.joinpath(vim.env.HOME, '.cargo/bin/cargo')
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  require('blink.cmp').setup({
    fuzzy = {
      implementation = 'rust',
    },
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
      ['<C-y>'] = {
        'select_and_accept',
        function() return vim.lsp.inline_completion.get() end,
        'fallback' },
      ['<cr>'] = { 'select_and_accept', 'fallback' },
      ['<c-j>'] = { 'snippet_forward', 'fallback' },
      ['<c-f>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-b>'] = { 'scroll_documentation_down', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'omni', 'lazydev', 'path' },
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
        snippets = {
          max_items = 3,
        },
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
        },
      },
    },
  })
end)
