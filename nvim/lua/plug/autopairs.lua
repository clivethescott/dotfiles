local ok, npairs = pcall(require, 'nvim-autopairs')
if not ok then
  return
end

npairs.setup({
  fast_wrap = {
    map = '<c-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment'
  },
  disable_filetype = { "TelescopePrompt", "vim" },
  disable_in_macro = false, -- disable when recording or executing a macro
  disable_in_visualblock = false, -- disable when insert after visual block mode
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
  enable_moveright = true,
  enable_afterquote = true, -- add bracket pairs after quote
  enable_check_bracket_line = true, --- check pair if close bracket exists in same line
  enable_bracket_in_quote = true, --
  map_cr = true,
  map_bs = true, -- map the <BS> key
  map_c_h = false, -- Map the <C-h> key to delete a pair
  map_c_w = false, -- map <c-w> to delete a pair if possible
  check_ts = true, -- use treesitter to check for a pair
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
    javascript = { 'template_string' },
    java = false, -- e.g don't check treesitter on java
  }
})

-- Customise existing rules
-- local parens = npairs.get_rule('[')
-- parens.not_filetypes = { 'go'} -- no autopair for slices in Go

-- Add custom rules
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

npairs.add_rules({
  Rule('"""', '"""', { "scala", "java", "python" }), -- triple quoted strings
  Rule(':', '=', { "golang"})
    :with_pair(cond.not_inside_quote())
    :with_pair(cond.not_before_text('"'))
    :set_end_pair_length(0), -- assignment with type inference
})

local has_cmp, cmp = pcall(require, 'cmp')
if has_cmp then
  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end
