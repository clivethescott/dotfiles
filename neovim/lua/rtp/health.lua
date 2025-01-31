local must_install_tools = {
  fd = 'fd',
  rg = 'ripgrep',
  lsd = 'lsd',
  bat = 'Bat viewer',
  fzf = 'FZF Fuzzy finder',
  ['git-delta'] = 'Delta Git pretty diffs',
  ['ast-grep'] = 'AST grep',
  ['scala-cli'] = 'Scala CLI',
  hurl = 'Hurl REST client',
  jq = 'jq',
  lazygit = 'lazygit',
  zoxide = 'zoxide',
  atuin = 'atuin',
  procs = 'procs Process viewer',
  jless = 'jless JSON viewer',
}
local M = {}
M.check = function()
  vim.health.start("sys tools check")
  for cmd, tool in pairs(must_install_tools) do
    if vim.fn.executable(cmd) == 0 then
      vim.health.warn("'" .. tool .. "' not found")
    else
      vim.health.ok("'" .. tool .. "' found")
    end
  end
end
return M
