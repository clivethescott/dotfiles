local ok, treesitter_config = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter_config.setup {
  ensure_installed = { 'dockerfile', 'git_config', 'gitcommit', 'go', 'gomod', 'graphql', 'hocon', 'html', 'javascript',
    'json', 'lua', 'make', 'markdown', 'proto', 'python', 'rust', 'scala', 'sql', 'terraform', 'toml', 'typescript',
    'vim', 'yaml' },
  auto_install = true,
  highlight = {
    enable = true,                            -- false will disable the whole extension
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
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = { query = '@function.outer', desc = 'Select outer function' },
        ['ap'] = { query = '@parameter.outer', desc = 'Select outer parameter' },
        ['ip'] = { query = '@parameter.inner', desc = 'Select inner parameter' },
        ['if'] = { query = '@function.inner', desc = 'Select inner function' },
        ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
        ['ic'] = { query = '@class.inner', desc = 'Select inner class' },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ['[c'] = { query = '@class.outer', desc = 'Go to prev class' },
        ['[p'] = { query = '@parmeter.outer', desc = 'Go to prev param' },
        ['[m'] = { query = '@function.outer', desc = 'Go to prev function' },
      },
      goto_next_start = {
        [']c'] = { query = '@class.outer', desc = 'Go to next class' },
        [']p'] = { query = '@parmeter.outer', desc = 'Go to next param' },
        [']m'] = { query = '@function.outer', desc = 'Go to next function' },
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
    enable = false,
  },
}

local ctx_ok, ctx = pcall(require, 'treesitter-context')
if not ctx_ok then
  return
end

ctx.setup {}
