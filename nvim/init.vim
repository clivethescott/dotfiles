" Make nvim use Vim's config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.config/nvim/viml/nvim-options.vim
source $HOME/.config/nvim/viml/abbreviations.vim
source $HOME/.config/nvim/viml/vim-plug.vim
source $HOME/.config/nvim/viml/colorscheme.vim
source $HOME/.config/nvim/viml/nvim-keymap.vim

" Plugin Configuration
source $HOME/.config/nvim/viml/startify.vim
" source $HOME/.config/nvim/opts/coc-options.vim
source $HOME/.config/nvim/viml/vimgo.vim
source $HOME/.config/nvim/viml/lightline.vim
source $HOME/.config/nvim/viml/fzf.vim
source $HOME/.config/nvim/viml/gitgutter.vim
source $HOME/.config/nvim/viml/fugitive.vim
source $HOME/.config/nvim/viml/undotree.vim
source $HOME/.config/nvim/viml/fern.vim
source $HOME/.config/nvim/viml/snippets.vim
source $HOME/.config/nvim/viml/coc.vim
source $HOME/.config/nvim/viml/startify.vim
source $HOME/.config/nvim/viml/autogroups.vim

lua <<EOF
-- require('lsp-config')
-- require('nvim-compe')
-- require('dart-lsp')
require('treesitter')
EOF

