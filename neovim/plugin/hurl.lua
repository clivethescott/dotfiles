vim.api.nvim_create_autocmd('FileType', {
  once = true,
  pattern = 'hurl',
  callback = function()
    vim.pack.add({ { src = 'https://github.com/clivethescott/hurl.nvim' } })

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
