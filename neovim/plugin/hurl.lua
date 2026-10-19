local loaded = false
local function load_hurl()
  if loaded then return end
  loaded = true
  vim.pack.add({ { src = 'https://github.com/clivethescott/hurl.nvim', version = 'develop' } })

  require('hurl').setup({
    mode = 'split',
    env_file = { vim.fs.normalize('~/Code/Hurl/prod.env') },
    auto_close = false,
    fixture_vars = {
      {
        name = 'later',
        callback = function() return os.date('!%Y-%m-%dT%H:%M:%SZ', os.time() + 366 * 86400) end,
      },
    },
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'hurl',
  callback = load_hurl,
})

-- Runnable lines of the ```hurl fenced block under the cursor
local function hurl_block_at_cursor()
  -- loading hurl.nvim swaps this buffer's cached markdown parser for a hurl one
  vim.treesitter.get_parser(0, 'markdown'):parse()
  local node = vim.treesitter.get_node()
  -- climb from the cursor node to the enclosing fenced block
  while node and node:type() ~= 'fenced_code_block' do node = node:parent() end
  if not node then return end

  -- the block must be tagged hurl; info_string also holds extras like `title=x`, so only read `language`
  local is_hurl, content = false, nil
  for child in node:iter_children() do
    if child:type() == 'info_string' then
      for lang in child:iter_children() do
        if lang:type() == 'language' then
          is_hurl = vim.treesitter.get_node_text(lang, 0) == 'hurl'
        end
      end
    elseif child:type() == 'code_fence_content' then
      content = child
    end
  end
  if not (is_hurl and content) then return end

  -- inside a callout/blockquote every line after the first keeps its `> ` prefix, which hurl can't parse
  local quote_depth, parent = 0, node:parent()
  while parent do
    if parent:type() == 'block_quote' then quote_depth = quote_depth + 1 end
    parent = parent:parent()
  end

  -- a block of only blanks/comments has no entry, and hurl.nvim errors on it
  local lines, runnable = {}, false
  for _, line in ipairs(vim.split(vim.treesitter.get_node_text(content, 0), '\n', { trimempty = true })) do
    for _ = 1, quote_depth do line = line:gsub('^%s*>%s?', '', 1) end
    if not (line:match('^%s*$') or line:match('^%s*#')) then runnable = true end
    lines[#lines + 1] = line
  end
  if runnable then return lines end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(ev)
    vim.keymap.set('n', '<space>hr', function()
      local block = hurl_block_at_cursor()
      if not block then
        vim.notify('hurl: no runnable ```hurl block at cursor', vim.log.levels.INFO)
        return
      end
      load_hurl()
      -- hurl runs files, so write the block to a temp file and delete it once hurl has read it
      local tmp = vim.fn.tempname() .. '.hurl'
      vim.fn.writefile(block, tmp)
      require('hurl.lib.hurl_runner').execute_hurl_cmd({ tmp })
      vim.defer_fn(function() os.remove(tmp) end, 1000)
    end, { buffer = ev.buf, desc = 'Run hurl code block' })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'hurl',
  callback = function(ev)
    local function map(lhs, cmd, desc, mode)
      vim.keymap.set(mode or 'n', lhs, '<cmd>' .. cmd .. '<cr>', { buffer = ev.buf, desc = desc })
    end
    map('<space>hr', 'HurlRunnerAt', 'Send request')
    map('<space>hr', 'HurlRunner', 'Send selected requests', 'v')
    map('<space>ha', 'HurlRunner', 'Send all requests')
    map('<space>hl', 'HurlShowLastResponse', 'Show last response')
    map('<space>hp', 'HurlPasteCurl', 'Paste curl as Hurl')
    map('<space>hh', 'HurlToggleMode', 'Toggle split/popup')
    map('<space>ht', 'HurlVerbose', 'Send request (verbose)')
    map('<space>he', 'HurlSelectEnvFile', 'Select environment')
    map('<space>hE', 'HurlManageVariable', 'Show variables')
  end
})
