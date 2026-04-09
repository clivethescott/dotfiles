vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.cmd.colorscheme('catppuccin')
vim.cmd.packadd('Cfilter')       -- filter qflist
vim.cmd.packadd('nvim.difftool') -- OR :packadd nvim.difftool :Difftool -- setup for gitdiff tool -d
vim.cmd.packadd('nvim.undotree') -- :Undotree -- set :h undolist for cmds

require('vim._core.ui2').enable({
  enable = true,
  msg = {
    target = 'msg',
    timeout = 1000,
    msg = {           -- Options related to msg window.
      timeout = 2000, -- Time a message is visible in the message window.
    },
  },
})

-- Options
vim.opt.dictionary:append('/usr/share/dict/words')
vim.opt.spell = true
vim.opt.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.opt.spelllang = 'en_gb'
vim.opt.splitright = true
vim.opt.list = true
vim.opt.listchars = "tab:··,leadmultispace:·"
vim.opt.termguicolors = true
vim.opt.lazyredraw = true
vim.o.winborder = 'rounded'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.backup = false
vim.opt.writebackup = false
---@diagnostic disable-next-line: param-type-mismatch
vim.opt.undodir = vim.fs.joinpath(vim.fn.stdpath('data'), 'undodir')
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 100
vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*.jar', '*/node_modules/*', '*/target/*',
  '*/.git/*', '*.class', '*.pyc', '*/plugged/*', '*/undodir/*', '*.png', '*.dex' })
vim.o.timeout = true
vim.opt.timeoutlen = 700
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " ", eob = " " })
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.modeline = true
vim.opt.inccommand = "split"
vim.opt.scrolloff = 1
vim.opt.conceallevel = 1
vim.opt.formatoptions:remove "o"
vim.opt.showmode = false
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy', 'popup' }
vim.o.pumborder = 'rounded'
vim.o.pummaxwidth = 60
vim.opt.shortmess:append('c')
vim.o.autocomplete = true

local cwd = vim.fn.getcwd()
if cwd:find('IdeaProjects') then
  -- shada per project
  vim.opt.shadafile = (function()
    local data = vim.fn.stdpath("data")
    cwd = vim.fs.root(cwd, ".git") or cwd
    local cwd_b64 = vim.base64.encode(cwd)
    local file = vim.fs.joinpath(data, "project_shada", cwd_b64)
    vim.fn.mkdir(vim.fs.dirname(file), "p")
    return file
  end)()
end

    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#626262' })
-- https://www.reddit.com/r/neovim/comments/1rcvliq/ghostty_lsp_progress_bar
vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup('MyLspGroup', { clear = true }),
  callback = function(ev)
    local value = ev.data.params.value or {}
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local client_name = client and client.name or 'unknown'
    -- if client_name == 'lua_ls' and string.find(value.title,  'Diagnosing workspace') then return end
    local msg = value.message or "done"

    -- rust analyszer in particular has really long LSP messages so truncate them
    if #msg > 60 then
      msg = msg:sub(1, 57) .. "..."
    end

    -- :h LspProgress
    vim.api.nvim_echo({ { msg } }, false, {
      id = "lsp",
      kind = "progress",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
      source = client_name,
    })
  end,
})
-- Commands
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'CurSearch',
      timeout = 500 -- time in ms before highlight is cleared
    }
  end,
  group = vim.api.nvim_create_augroup('MyYankHighlight', { clear = true }),
  pattern = '*',
})

-- Native Neovim 0.12 completion options and keymaps
-- Replaces blink.cmp configuration

-- Confirm selected completion item with <cr>, or insert newline if menu not visible
vim.keymap.set('i', '<cr>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<cr>'
end, { expr = true, desc = 'Confirm completion or newline' })

-- Snippet navigation (replaces blink snippet_forward / snippet_backward)
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if vim.snippet.active({ direction = 1 }) then vim.snippet.jump(1) end
end, { desc = 'Snippet: jump forward' })

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if vim.snippet.active({ direction = -1 }) then vim.snippet.jump(-1) end
end, { desc = 'Snippet: jump back' })

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update(nil, { force = true })
end, { desc = 'Update plugins' })

-- :h vim.pack Synchronize config across machines ~
vim.api.nvim_create_user_command('PackSync', function()
  vim.pack.update(nil, { target = 'lockfile' })
end, { desc = 'Sync plugin state' })


-- :h nvim_open_term
-- https://www.youtube.com/watch?v=EiBg91LTOYk&t=3947s
vim.api.nvim_create_user_command('TermHl', function()
  vim.api.nvim_open_term(0, {})
end, { desc = 'Highlights ANSI termcodes in curbuf' })

Statusline = {}
Statusline.lspInfo = function()
  return vim.diagnostic.status() .. ' ' .. vim.ui.progress_status() .. ' '
end
Statusline.gitInfo = function()
  local git = vim.b.gitsigns_status_dict
  local git_branch = (git and git.head) and ' ' .. git.head or ''
  if git_branch ~= '' then
    git_branch = '%#StatusLineGitBranch#' .. git_branch .. '%#StatusLine#'
  end

  -- simpler one would be vim.b.gitsigns_status, but has no colors
  local git_status = ''
  if git then
    if git.added and git.added > 0 then
      git_status = git_status .. '%#StatusLineGitAdded# +' .. git.added
    end
    if git.changed and git.changed > 0 then
      git_status = git_status .. '%#StatusLineGitChanged# ~' .. git.changed
    end
    if git.removed and git.removed > 0 then
      git_status = git_status .. '%#StatusLineGitRemoved# -' .. git.removed
    end
    -- Return to normal statusline color after git status
    if git_status ~= '' then
      git_status = git_status .. '%#StatusLine#'
    end
  end

  return string.format(
    ' %s%s ',
    git_branch,
    git_status
  )
end

Statusline.active = function()
  return table.concat({
    Statusline.short_path(),
    ' %y', -- file type
    ' %m', -- [modified] flag
    ' %r', -- [readonly] flag
    ' %h', -- [help buffer] flag
    '%=',  -- right align from here
    Statusline.lspInfo(),
    Statusline.gitInfo(),
  })
end

Statusline.short_path = function()
  local file = vim.api.nvim_buf_get_name(0)
  local parts = vim.split(file, '/')

  local take_last = 3
  if #parts <= take_last then
    return file
  end

  return '...' .. table.concat(parts, '/', math.max(1, #parts - take_last))
end

Statusline.inactive = function()
  return table.concat({
    " %f " -- filename with path
  })
end
local statusline_group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = statusline_group,
  desc = "Activate statusline on focus",
  callback = function()
    vim.wo.statusline = "%!v:lua.Statusline.active()"
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = statusline_group,
  desc = "Deactivate statusline when unfocused",
  callback = function()
    vim.wo.statusline = "%!v:lua.Statusline.inactive()"
  end,
})

-- Keybindings
vim.keymap.set('n', '<C-s>', ':silent update<cr>')
vim.keymap.set('i', '<C-s>', '<esc>:silent update<cr>')
vim.keymap.set('i', '<C-z>', '<esc>:undo<cr>')
vim.keymap.set('n', '<M-v>', '"*p')
vim.keymap.set({ 'n', 'v', 's' }, '<M-y>', '"*y')
vim.keymap.set('i', '<M-v>', '<esc>"*p')
vim.keymap.set('n', 'gh', '<cmd>:help!<cr>', { desc = 'Improved help' })
vim.keymap.set("n", "k", function() return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "k" end, { expr = true })
vim.keymap.set("n", "j", function() return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "j" end, { expr = true })
vim.keymap.set('n', '<space>lD', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
  { desc = 'Toggle diagnostics' })
vim.keymap.set('n', 'Q', ':qa<cr>')
vim.keymap.set('n', '<leader>q', ':qa!<cr>')
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('n', "'", '`')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('n', '<space>x', ":.lua<cr>", { silent = true, desc = 'Exec Lua' })
vim.keymap.set('n', '<space>X', "<cmd>source %<cr>", { silent = true, desc = 'Exec Lua file' })
vim.keymap.set('v', '<space>x', ":lua<cr>", { silent = true, desc = 'Exec Lua' })
vim.keymap.set({ 'x', 'n' }, '&', ':&&<cr>', { desc = 'Repeat last substitute keeping flags' })

-- nicer :find
function Fd(match)
  local files = vim.fn.systemlist(
    'fd --type file --follow --color=never --max-depth=8 --exclude ".git" --exclude "target" --full-path '
    .. match
  )
  return vim.fn.matchfuzzy(files, match)
end

vim.opt.findfunc = "v:lua.Fd"

-- Whole buffer text object
vim.keymap.set('o', 'ig', ':<C-u>normal! ggVG<CR>', { desc = 'Inner whole buffer' })
vim.keymap.set('o', 'ag', ':<C-u>normal! ggVG<CR>', { desc = 'Around whole buffer' })
vim.keymap.set('x', 'ig', ':<C-u>normal! ggVG<CR>', { desc = 'Inner whole buffer' })
vim.keymap.set('x', 'ag', ':<C-u>normal! ggVG<CR>', { desc = 'Around whole buffer' })
vim.keymap.set('n', '<space>ol', function() vim.pack.update(nil, { force = false }) end,
  { desc = 'Show packages with updates' })

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup('LspAttachedGroup', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

      vim.keymap.set('i', '<C-.>', vim.lsp.inline_completion.get,
        { desc = 'LSP: accept inline completion', buffer = bufnr })
      vim.keymap.set('i', '<C-G>', vim.lsp.inline_completion.select,
        { desc = 'LSP: switch inline completion', buffer = bufnr })
    end

    -- :h vim.lsp.foldexpr
    if client:supports_method('textDocument/foldingRange', bufnr) then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end


    if client:supports_method('textDocument/completion', bufnr) then
      local icons = {
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰜢',
        Variable = '󰀫',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '󰑭',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '󰈇',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰊄'
      }
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
          local name = vim.lsp.protocol.CompletionItemKind[item.kind]
          local icon = name and icons[name]
          if icon then
            item.abbr = icon .. ' ' .. (item.label or '')
            item.kind = ''
          end
          return item
        end,
      })
    end

    if client:supports_method('textDocument/signatureHelp', bufnr) then
      vim.keymap.set({ 'n', 'i' }, '<M-s>', vim.lsp.buf.signature_help, { buffer = true, desc = 'Signature help' })
    end

    if client:supports_method('textDocument/inlayHint', bufnr) then
      vim.keymap.set({ 'n', 'i' }, '<M-i>',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = 'Toggle inlay hints' })
    end

    if client:supports_method('textDocument/formatting', bufnr) then
      vim.keymap.set({ 'n', 'v' }, '<leader>f', vim.lsp.buf.format, { buffer = true, desc = 'LSP Format' })
      vim.b.formatexpr = "v:lua.vim.lsp.formatexpr()"
    else
      vim.print('formatting not supported!')
    end
  end
})

local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    },
    semanticTokens = {
      multilineTokenSupport = true,
    },
    completionitem = {
      snippetSupport = true,
      resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" }
      }
    }
  }
}
capabilities       = vim.tbl_deep_extend('force', capabilities, vim.lsp.protocol.make_client_capabilities())
vim.env.PATH       = vim.env.PATH .. ':' .. vim.fn.expand('~/.local/share/nvim/mason/bin')
vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      diagnostics = {
        globals = { 'vim', 'wezterm' },
        unusedLocalExcludes = { '_*' },
        disable = { 'missing-fields', 'missing-parameter' },
      },
      format = {
        enable = true,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      }
    },
  },
})

vim.lsp.enable({ 'lua_ls' })
