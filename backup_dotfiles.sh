#!/usr/bin/env zsh

DOTFILES_HOME=$HOME/dotfiles
cp -r $HOME/.vim/vimrc $HOME/.vim/after $DOTFILES_HOME/vim
cp -r $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp -r $HOME/.config/nvim/*.{vim,json} $HOME/.config/nvim/UltiSnips $DOTFILES_HOME/nvim
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
