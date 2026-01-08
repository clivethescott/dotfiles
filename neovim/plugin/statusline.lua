Statusline = {}

-- see :h statusline for more info

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

Statusline.httpEnv = function()
  if vim.bo.filetype == 'http' then
    local has_kulala, kulala = pcall(require, 'kulala')
    if has_kulala then
      local env = kulala.get_selected_env() or 'unknown'
      return '[' .. env:upper() .. ']'
    end
  end
  return ''
end

Statusline.active = function()
  return table.concat({
    Statusline.short_path(),
    ' %y', -- file type
    ' %m', -- [modified] flag
    ' %r', -- [readonly] flag
    ' %h', -- [help buffer] flag
    '%=',  -- right align from here
    Statusline.httpEnv(),
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

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = group,
  desc = "Activate statusline on focus",
  callback = function()
    vim.wo.statusline = "%!v:lua.Statusline.active()"
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = group,
  desc = "Deactivate statusline when unfocused",
  callback = function()
    vim.wo.statusline = "%!v:lua.Statusline.inactive()"
  end,
})
