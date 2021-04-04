#!/usr/bin/env sh

old_dir=$(pwd)
DOTFILES_HOME=$HOME/dotfiles
cp $HOME/.config/nvim/snippets/*.snippets $DOTFILES_HOME/nvim/snippets
cp $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp $HOME/.config/nvim/init.vim $DOTFILES_HOME/nvim/init.vim
cp $HOME/.config/nvim/viml/*.vim $DOTFILES_HOME/nvim/viml
cp $HOME/.config/nvim/lua/*.lua $DOTFILES_HOME/nvim/lua
cp $HOME/.config/nvim/coc-settings.json $DOTFILES_HOME/nvim/coc-settings.json
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim/.ideavimrc
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep/.ripgreprc
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux/.tmux.conf
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
cp $HOME/.config/alacritty/alacritty.yml $DOTFILES_HOME/alacritty/alacritty.yml
cp $HOME/.config/ranger/rc.conf $DOTFILES_HOME/ranger/rc.conf
cp $HOME/.config/ranger/rifle.conf $DOTFILES_HOME/ranger/rifle.conf
cp $HOME/.config/ranger/commands.py $DOTFILES_HOME/ranger/commands.py
cd $DOTFILES_HOME
git add .
git commit
git push
cd $old_dir

