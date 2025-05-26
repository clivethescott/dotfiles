local must_install_tools = {
  fd = 'fd',
  rg = 'ripgrep',
  lsd = 'lsd',
  bat = 'Bat viewer',
  fzf = 'FZF Fuzzy finder',
  delta = 'Delta Git pretty diffs',
  difft = 'difftastic diffs with Treesitter',
  ['ast-grep'] = 'AST grep',
  ['scala'] = 'Scala CLI',
  hurl = 'Hurl REST client',
  jq = 'jq',
  lazygit = 'lazygit',
  zoxide = 'zoxide',
  atuin = 'atuin',
  procs = 'procs Process viewer',
  jless = 'jless JSON viewer',
  nu = 'nu shell',
  presenterm = 'presenterm',
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
