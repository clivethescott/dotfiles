local M = {}

function M.resolvedCapabilities(client_id)
  client_id = client_id or 1
  print(vim.inspect(vim.lsp.buf_get_clients()[client_id].server_capabilities))
end

function M.uuid()
  return string.lower(require 'os'.execute("uuidgen | tr -d '\n'"))
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
    local file_path = vim.api.nvim_eval_statusline('%f', {}).str
    local modified = vim.api.nvim_eval_statusline('%m', {}).str

    file_path =  '   ' .. file_path:gsub('/', ' ➤ ')

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

local function count_lsp_res_changes(lsp_results)
  local count = { instances = 0, files = 0 }
  if (lsp_results.documentChanges) then
    for _, changed_file in pairs(lsp_results.documentChanges) do
      count.files = count.files + 1
      count.instances = count.instances + #changed_file.edits
    end
  elseif (lsp_results.changes) then
    for _, changed_file in pairs(lsp_results.changes) do
      count.instances = count.instances + #changed_file
      count.files = count.files + 1
    end
  end
  return count
end

function M.rename()
  local curr_name = vim.fn.expand("<cword>")
  local input_opts = {
    prompt = 'LSP Rename',
    default = curr_name
  }
  -- ask user input
  vim.ui.input(input_opts, function(new_name)
    -- check new_name is valid
    if not new_name or #new_name == 0 or curr_name == new_name then return end
    -- request lsp rename
    local params = vim.lsp.util.make_position_params()
    params.newName = new_name
    vim.lsp.buf_request(0, "textDocument/rename", params, function(_, res, ctx, _)
      if not res then return end
      -- apply renames
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)
      -- display a message
      local changes = count_lsp_res_changes(res)
      local message = string.format("renamed %s instance%s in %s file%s. %s",
        changes.instances,
        changes.instances == 1 and '' or 's',
        changes.files,
        changes.files == 1 and '' or 's',
        changes.files > 1 and "To save them run ':wa'" or ''
      )
      vim.notify(message)
    end)
  end)
end

return M
