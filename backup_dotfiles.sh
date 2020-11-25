#!/usr/bin/env sh

DOTFILES_HOME=$HOME/dotfiles
cp $HOME/.config/nvim/UltiSnips/*.snippets $DOTFILES_HOME/nvim/UltiSnips
cp $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp $HOME/.vim/after/ftplugin/*.vim $DOTFILES_HOME/vim/after/ftplugin
cp $HOME/.config/nvim/init.vim $DOTFILES_HOME/nvim
cp $HOME/.config/nvim/opts/*.vim $DOTFILES_HOME/nvim/opts
cp $HOME/.config/nvim/coc-settings.json $DOTFILES_HOME/nvim
cp $HOME/.config/coc/ultisnips/*.snippets $DOTFILES_HOME/nvim/UltiSnips
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
