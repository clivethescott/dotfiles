return {
  "Saecki/crates.nvim",
  tag = 'stable',
  event = { "BufRead Cargo.toml" },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = true,
  cond = function()
    return require 'helper.utils'.plugin_conf().rust_enabled
  end,
}
