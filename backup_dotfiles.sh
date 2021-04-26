#!/usr/bin/env sh

old_dir=$(pwd)
DOTFILES_HOME=$HOME/dotfiles
NVIM_HOME=$HOME/.config/nvim
cp $NVIM_HOME/snippets/*.snippets $DOTFILES_HOME/nvim/snippets
cp $NVIM_HOME/init2.vim $DOTFILES_HOME/nvim/init.vim
cp $NVIM_HOME/init.lua $DOTFILES_HOME/nvim/init.lua
cp $NVIM_HOME/viml/*.vim $DOTFILES_HOME/nvim/viml
cp -r $NVIM_HOME/lua $DOTFILES_HOME/nvim
cp $NVIM_HOME/coc-settings.json $DOTFILES_HOME/nvim/coc-settings.json
cp $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
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

