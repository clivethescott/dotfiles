vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.o.completeopt = "menuone,noselect"

vim.cmd[[
function! Auto_complete_string()                               
    if pumvisible()                                            
        return "\<C-n>"                                        
    else                                                       
        return "\<C-x>\<C-o>\<C-r>=Auto_complete_opened()\<CR>"
    end                                                        
endfunction                                                    

function! Auto_complete_opened()                               
    if pumvisible()                                            
        return "\<c-n>\<c-p>\<c-n>"                            
    else                                                       
        return "\<bs>\<C-n>"                                   
    end                                                        
endfunction                                                    

inoremap <expr> <Nul> Auto_complete_string()
inoremap <expr> <C-Space> Auto_complete_string()
]]
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 500;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

local map = vim.api.nvim_set_keymap
local opts = { expr = true }
map("i", "<Tab>", "v:lua.tab_complete()", opts)
map("s", "<Tab>", "v:lua.tab_complete()", opts)
map("i", "<S-Tab>", "v:lua.s_tab_complete()", opts)
map('i', '<cr>', "compe#confirm('<cr>')", opts)
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", opts)

