return {
  'romgrk/nvim-treesitter-context',
  ft = { 'python', 'yaml', 'json', 'go', 'scala' },
  config = true,
  event = 'InsertEnter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'InsertEnter' },
    {
      'windwp/nvim-ts-autotag',
      ft = { 'html' },
      event = 'InsertEnter',
    },
    { 'nvim-treesitter/playground',                  cmd = 'TSPlaygroundToggle' }
  }
}
