return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    map_cr = false, -- https://github.com/Saghen/blink.cmp/issues/20
    check_ts = true
  },
}
