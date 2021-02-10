" Make nvim use Vim's config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.config/nvim/opts/options.vim
source $HOME/.config/nvim/opts/plugins.vim
source $HOME/.config/nvim/opts/colorscheme.vim
source $HOME/.config/nvim/opts/keymaps.vim
source $HOME/.config/nvim/opts/startify.vim

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

