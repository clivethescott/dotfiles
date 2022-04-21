local lspconfig = require 'lspconfig'

local function novcs()
  local root_dir = lspconfig.util.find_git_ancestor(vim.api.nvim_buf_get_name(0))
  return root_dir == nil or root_dir == ''
end

local M = {}
local api = vim.api
function M.gitBlame()
  if novcs() then return end
  local ft = vim.fn.expand('%:h:t') -- get the current file extension
  if ft == '' then return end -- if we are in a scratch buffer or unknown filetype
  if ft == 'bin' then return end -- if we are in nvim's terminal window
  if ft == 'help' then return end -- if we are in help
  api.nvim_buf_clear_namespace(0, 2, 0, -1) -- clear out virtual text from namespace 2 (the namespace we will set later)
  local currFile = vim.fn.expand('%')
  local line = api.nvim_win_get_cursor(0)
  local blame = vim.fn.system(string.format('git blame -c -L %d,%d %s', line[1], line[1], currFile))
  local hash = vim.split(blame, '%s')[1]
  local cmd = string.format("git show %s ", hash) .. "--format='%an | %ar | %s'"
  local text
  if hash == '00000000' then
    text = 'Not Tracked'
  else
    text = vim.fn.system(cmd)
    text = vim.split(text, '\n')[1]
    if text:find("fatal") then -- if the call to git show fails
      text = 'Not Tracked'
    end
  end
  api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, { { text, 'GitLens' } }, {}) -- set virtual text for namespace 2 with the content from git and assign it to the higlight group 'GitLens'
end

function M.gitBlameClear() -- important for clearing out the text when our cursor moves
  if novcs() then return end
  api.nvim_buf_clear_namespace(0, 2, 0, -1)
end

function M.resolvedCapabilities()
  print(vim.inspect(vim.lsp.buf_get_clients()[1].resolved_capabilities))
end

return M
