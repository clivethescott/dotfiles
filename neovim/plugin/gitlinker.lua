if not vim.g.is_work_pc then return end

--- @param link gitlinker.Linker
--- @return string
local function github_browse(link)
  local repo = (link.repo or ""):gsub("%.git$", "")
  local location = string.format("%s?plain=1#L%d", link.file, link.lstart)
  if link.lend > link.lstart then
    location = location .. string.format("-L%d", link.lend)
  end
  return table.concat({
    "https://" .. link.host,
    link.org,
    repo,
    "blob",
    link.rev,
    location,
  }, "/")
end

vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/linrongbin16/gitlinker.nvim' } })

  require 'gitlinker'.setup {
    router = {
      browse = {
        ["^github%.bamtech%.co"] = github_browse,
        ["^github%.twdcgrid%.net"] = github_browse,
        ["^github%.prod%.hulu%.com"] = github_browse,
      }
    }
  }

  vim.keymap.set({ "n", "v" }, "<space>gy", "<cmd>GitLink<cr>",  { desc = "Yank git link" })
  vim.keymap.set({ "n", "v" }, "<space>gY", "<cmd>GitLink!<cr>", { desc = "Open git link" })
end)
