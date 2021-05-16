local on_attach = function(client, bufnr)
  print('Attaching to ' .. client.name)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', ',d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', ',D', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	      autocmd BufWritePre *{.dart,go} lua vim.lsp.buf.formatting_sync(null, 300)
      augroup END
    ]], false)
  end
end

local lspconfig = require('lspconfig')

----------------------------------------------------------------------
-- Flutter LSP CONFIG - should not be enabled simultaneously with Flutter CONFIG
-- load flutter commands into telescope
require("flutter-tools").setup {
  flutter_path = '/home/clive/snap/flutter/common/flutter/bin/flutter',
  widget_guides = {
    enabled = true,
  },
  dev_log = {
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  outline = {
    open_cmd = "70vnew", -- command to use to open the outline buffer
  },
  lsp = {
    on_attach = on_attach,
    settings = {
      showTodos = true,
      completeFunctionCalls = true -- NOTE: this is WIP and doesn't work currently
    }
  }
}
----------------------------------------------------------------------
-- DART LSP CONFIG - should NOT be enabled simultaneously with Flutter CONFIG
----------------------------------------------------------------------
-- lspconfig.dartls.setup{
--     root_dir = lspconfig.util.root_pattern("pubspec.yaml");
--     filetypes = {'dart', 'yaml'};
--     on_attach = on_attach;
--     cmd = {
--         "dart",
--         "/home/clive/snap/flutter/common/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot",
--         "--lsp",
--         "--client-id",
--         "neovim"
--     },
--     init_options = {
--       closingLabels = true,
--       flutterOutline = true,
--       outline = true,
--       allowAnalytics = false,
--       autoImportCompletions = true,
--     }
-- }
----------------------------------------------------------------------
-- GO LSP CONFIG
----------------------------------------------------------------------
lspconfig.gopls.setup{
  filetypes = {'go'};
  on_attach = on_attach;
}
----------------------------------------------------------------------
-- LUA LSP CONFIG
----------------------------------------------------------------------
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = os.getenv('HOME') .. '/apps/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lspconfig.sumneko_lua.setup {
  on_attach = on_attach;
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
	preloadFileSize = 500,
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
----------------------------------------------------------------------
-- Python LSP CONFIG
----------------------------------------------------------------------
require'lspconfig'.pyright.setup{
  on_attach = on_attach;
  settings = {
    python = {
      pythonPath = '/usr/bin/python3',
      analysis = {
        loglevel = 'Error',
        typeCheckingMode = 'strict'
      }
    }
  }
}
