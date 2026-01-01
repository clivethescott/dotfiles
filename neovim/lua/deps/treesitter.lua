-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`
-- To see available languages:
-- - Execute `:=require('nvim-treesitter').get_available()`
-- - Visit 'SUPPORTED_LANGUAGES.md' file at
--   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
local ensure_installed = {
  'lua', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
  -- NOTE: the above are natively installed since neovim 0.12
  'bash', 'dockerfile', 'git_config', 'gitcommit', 'graphql', 'hocon', 'html', 'smithy',
  'helm', 'http', 'properties', 'json', 'python', 'rust', 'diff', 'hcl', 'nu',
  'scala', 'sql', 'toml', 'yaml', 'fish', 'hurl', 'csv', 'go', 'groovy', 'java', 'proto',
  'terraform', 'typescript',
}
local disable_indent_fts = { 'ocaml' }
local regex_highlight_fts = {'fugitive'}

-- https://www.reddit.com/r/neovim/comments/1ow2m75/comment/nonf4nt/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
local needs_install = function(lang)
  local return_all_matches = false
  local parsers = vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', return_all_matches)
  return #parsers == 0
end

local install_missing_parsers = function()
  local missing_parsers = vim.tbl_filter(needs_install, ensure_installed)
  if #missing_parsers > 0 then
    vim.notify('Installing missing parsers = ' .. table.concat(missing_parsers, ','), vim.log.levels.INFO)
    require 'nvim-treesitter'.install(missing_parsers)
  end
end

local get_supported_filetypes = function()
  -- Ensure tree-sitter enabled after opening a file for target language
  local filetypes = {}
  for _, lang in ipairs(ensure_installed) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  return filetypes
end

local select_textobject = function(...)
  require "nvim-treesitter-textobjects.select".select_textobject(...)
end
local goto_next = function(...)
  require "nvim-treesitter-textobjects.move".goto_next_start(...)
end
local goto_previous = function(...)
  require "nvim-treesitter-textobjects.move".goto_previous_end(...)
end

return {
  'nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
  dependencies = {
    {
      'nvim-treesitter-textobjects',
      branch = 'main',
      after = function()
        require('nvim-treesitter-textobjects').setup({
          move = {
            -- whether to set jumps in the jumplist
            set_jumps = true,
          },
        })
      end,
      keys = {
        -- You can use the capture groups defined in `textobjects.scm`
        {
          'af',
          function() select_textobject("@function.outer", "textobjects") end,
          desc = 'Select outer function',
          mode = { 'x', 'o' }
        },
        {
          'if',
          function() select_textobject("@function.inner", "textobjects") end,
          desc = 'Select inner function',
          mode = { 'x', 'o' }
        },
        -- This is similar to ]m, [m, Neovim's mappings to jump to the next or previous function.
        {
          ']m',
          function() goto_next({ "@function.outer", "@class.outer" }, "textobjects") end,
          desc = 'Go to next function or class',
          mode = { 'n', 'x', 'o' }
        },
        {
          '[m',
          function() goto_previous({ "@function.outer", "@class.outer" }, "textobjects") end,
          desc = 'Go to prev function or class',
          mode = { 'n', 'x', 'o' }
        }
      }
    },
    {
      'nvim-treesitter-context',
      keys = {
        { '[h', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'Jump to TS context' },
        { ']h', function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = 'Jump to TS context' },
      },
      after = function()
        require('treesitter-context').setup({
          multiline_threshold = 999,
          -- separator = '-',
          max_lines = 1,
        })
      end,
    },
    {
      -- 'towolf/vim-helm', possible compat issues?
      "helm-ls.nvim",
      enabled = vim.g.is_work_pc,
      ft = { 'yaml', 'helm' },
    }
  },
  after = function()
    install_missing_parsers()

    local supported_filetypes = get_supported_filetypes()
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Start treesitter',
      -- WARN: Do not use pattern "*" here, only run on supported buffers, see below
      pattern = supported_filetypes,
      group = vim.api.nvim_create_augroup('treesitter.setup', { clear = true }),
      callback = function(args)
        local buf = args.buf
        local filetype = args.match

        if vim.tbl_contains(regex_highlight_fts, filetype) then
          vim.bo[buf].syntax = 'on' -- only if additional legacy syntax is needed
        end

        -- https://github.com/MeanderingProgrammer/treesitter-modules.nvim?tab=readme-ov-file#implementing-yourself
        --- you need some mechanism to avoid running on buffers that do not
        -- correspond to a language (like oil.nvim buffers), this implementation
        --- checks if a parser exists for the current language
        local language = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(language) then
          return
        end

        -- replicate `fold = { enable = true }`
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

        -- replicate `highlight = { enable = true }`
        vim.treesitter.start(buf, language)
        -- To replicate additional_vim_regex_highlighting = true
        -- regex syntax highlighting is disabled by default, which may be required for some plugins.
        -- after `vim.treesitter.start` call this if needed

        -- replicate `indent = { enable = true }`
        if not vim.tbl_contains(disable_indent_fts, filetype) then
          -- strange issue where let is indented? (set in :h indentkeys)
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
