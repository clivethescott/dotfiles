local M = {}
local cache = {}

function M.resolvedCapabilities(client_id)
  client_id = client_id or 1
  vim.print(vim.lsp.get_client_by_id(client_id).server_capabilities)
end

---@return obsidian.Picker|?
local get_obsidian_fzf_picker = function()
  local client = require 'obsidian'.get_client()
  local PickerName = require 'obsidian.config'.Picker
  local pickers = require 'obsidian'.pickers

  local picker = pickers.get(client, PickerName.fzf_lua)
  cache['obsidian_fzf_picker'] = picker

  return picker
end

function M.obsidian_search()
  local fzf_picker = cache['obsidian_fzf_picker'] or get_obsidian_fzf_picker()
  fzf_picker:grep_notes {
    prompt_title = 'Live Grep Notes',
    query = '',
    callback = function(path)
      vim.print(path)
    end,
  }
end

function M.lsp_client_capabilities()
  local server_capabilities =
      vim.lsp.protocol.make_client_capabilities()
  local has_ufo, _ = pcall(require, 'kevinhwang91/nvim-ufo')
  if has_ufo then
    server_capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  end
  server_capabilities.textDocument.completion.completionItem.snippetSupport = true -- broadcasting snippet capability for completion
  server_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  local has_blink, blink = pcall(require, 'blink.cmp')
  if has_cmp then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    server_capabilities = cmp_lsp.default_capabilities()
  elseif has_blink then
    server_capabilities = blink.get_lsp_capabilities()
  end
  return server_capabilities
end

function M.start_smithy()
  local launcher_path = vim.fs.joinpath(vim.fn.stdpath('config'), '/launchers/smithy-language-server')
  vim.lsp.start({
    name = 'smithy-language-server',
    cmd = { launcher_path }, -- see shell script for command
    root_dir = vim.fs.root(0, { 'smithy-build.json' }),
  }, {
    reuse_client = function() return true end,
    bufnr = 0,
    init_options = {
      statusBarProvider = 'show-message',
      isHttpEnabled = true,
      compilerOptions = {
        snippetAutoIndent = false,
      },
    },
    debounce_text_changes = 300,
  })
end

local smithy_file_types = { 'smithy' }
M.restart_smithy = function()
  for _, buf in pairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    if vim.tbl_contains(smithy_file_types, vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr })) then
      local clients = vim.lsp.get_clients({ buffer = buf.bufnr, name = "smithy-language-server" })
      for _, client in ipairs(clients) do
        client.stop()
      end
    end
  end

  vim.notify('Restarting Smithy')
  vim.defer_fn(function()
    M.start_smithy()
  end, 2000)
end

function M.uuid()
  local uuid = vim.fn.system("uuidgen | tr -d '\n'")
  return string.lower(uuid)
end

local system_open_uri = function(uri)
  if type(uri) ~= 'nil' then
    uri = string.gsub(uri, "#", "\\#") --double escapes any # signs
    uri = '"' .. uri .. '"'
    vim.cmd('!open ' .. uri .. ' > /dev/null')
    vim.cmd('mode')
    -- print(uri)
    return true
  else
    return false
  end
end

function M.open_uri()
  local word_under_cursor = vim.fn.expand("<cWORD>")
  -- any uri with a protocol segment
  local regex_protocol_uri = "%a*:%/%/[%a%d%#%[%]%-%%+:;!$@/?&=_.,~*]*"
  local is_open = system_open_uri(string.match(word_under_cursor, regex_protocol_uri))
  if is_open then
    return
  end
  -- consider anything that looks like string/string a github link
  local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
  if (system_open_uri('https://github.com/' .. string.match(word_under_cursor, regex_plugin_url))) then
    return
  end
end

function M.alt_scala_file()
  local cur_file = vim.fn.expand('%')
  local ext = vim.fn.fnamemodify(cur_file, ':e')

  -- alt scala ft files
  if ext == 'sbt' or ext == 'sc' then
    return
  end

  local code_file

  if vim.endswith(cur_file, 'Spec.scala') then
    code_file = string.gsub(cur_file, 'src/test', 'src/main')
    code_file = string.gsub(code_file, 'Spec.scala', '.scala')
  else
    code_file = string.gsub(cur_file, 'src/main', 'src/test')
    code_file = vim.fn.fnamemodify(code_file, ':r') .. 'Spec.scala'
  end

  local dir = vim.fn.fnamemodify(code_file, ':p:h')

  if vim.fn.isdirectory(dir) == 0 then
    require 'os'.execute('mkdir -p ' .. dir)
  end

  vim.fn.execute('edit ' .. code_file)
end

function M.nvim_winbar()
  if vim.fn.has('nvim-0.8') == 0 then return end

  local file_path = vim.api.nvim_eval_statusline('%f', {}).str
  local modified = vim.api.nvim_eval_statusline('%m', {}).str

  file_path = '   ' .. file_path:gsub('/', ' ➤ ')

  return '%#WinBarPath#'
      .. file_path
      .. '%*'
      .. '%#WinBarModified# '
      .. modified
      .. '%*'
end

function M.alt_go_file()
  local cur_file = vim.fn.expand('%')
  local edit_file
  if vim.endswith(cur_file, '_test.go') then
    edit_file = 'edit ' .. string.gsub(cur_file, '_test.go', '.go')
  else
    edit_file = 'edit ' .. vim.fn.fnamemodify(cur_file, ':r') .. '_test.go'
  end

  vim.fn.execute(edit_file)
end

-- local skip_lsp_format_clients = {}
local formatting_options = function(bufnr, async)
  async = async or true
  return {
    bufnr = bufnr or 0,
    timeout_ms = 2000,
    async = async,
    -- filter = function(client)
    --   return skip_lsp_format_clients[client.name] == nil
    -- end,
  }
end

function M.lsp_buf_format_sync(ev)
  local opts = formatting_options(ev.buf, false)
  vim.lsp.buf.format(opts)
end

function M.lsp_buf_format(bufnr)
  local opts = formatting_options(bufnr)
  vim.lsp.buf.format(opts)
end

function M.lsp_range_format(bufnr)
  local opts = formatting_options(bufnr)
  vim.lsp.buf.range_formatting(opts)
end

function M.show_word_help()
  local cword = vim.fn.expand("<cword>")
  vim.fn.execute('h ' .. cword)
end

function M.netrw_mark_list()
  vim.cmd [[echo join(netrw#Expose("netrwmarkfilelist"), "\n")]]
end

return M
