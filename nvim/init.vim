" Make nvim use Vim's config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source $HOME/.config/nvim/opts/options.vim
source $HOME/.config/nvim/opts/plugins.vim
source $HOME/.config/nvim/opts/colorscheme.vim
source $HOME/.config/nvim/opts/keymaps.vim
source $HOME/.config/nvim/opts/startify.vim
