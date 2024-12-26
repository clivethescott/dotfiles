return {
  { 'saghen/blink.compat', version = '*', lazy = true, opts = {} },
  {
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
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<tab>'] = {
          function(cmp)
            if cmp.visible then return end -- runs next command
            return true
          end, 'select_next'
        },
        ['<s-tab>'] = {
          function(cmp)
            if cmp.visible then return end -- runs next command
            return true
          end, 'select_prev'
        },
        cmdline = {
          preset = 'enter',
        }
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        accept = { auto_brackets = { enabled = true }, },
        list = { selection = 'preselect' },
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
      }
    }
  }
}
