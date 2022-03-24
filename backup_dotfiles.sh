#!/usr/bin/env sh

old_dir=$(pwd)
DOTFILES_HOME=$HOME/dotfiles
NVIM_HOME=$HOME/.config/nvim
RANGER_HOME=$HOME/.config/ranger
cp $NVIM_HOME/snippets/*.snippets $DOTFILES_HOME/nvim/snippets
cp $NVIM_HOME/init.vim $DOTFILES_HOME/nvim/init.vim
cp $NVIM_HOME/init.lua $DOTFILES_HOME/nvim/init.lua
cp $NVIM_HOME/settings/*.vim $DOTFILES_HOME/nvim/settings
cp -r $NVIM_HOME/lua $DOTFILES_HOME/nvim
cp $NVIM_HOME/coc-settings.json $DOTFILES_HOME/nvim/coc-settings.json
cp $NVIM_HOME/templates/* $DOTFILES_HOME/nvim/templates
cp $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim/.ideavimrc
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep/.ripgreprc
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux/.tmux.conf
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
cp $HOME/.zprofile $DOTFILES_HOME/zsh
cp $HOME/.config/alacritty/alacritty.yml $DOTFILES_HOME/alacritty/alacritty.yml
# Ranger
cp $RANGER_HOME/rc.conf $DOTFILES_HOME/ranger/rc.conf
cp $RANGER_HOME/rifle.conf $DOTFILES_HOME/ranger/rifle.conf
cp $RANGER_HOME/commands.py $DOTFILES_HOME/ranger/commands.py
cp $RANGER_HOME/utils/*.py $DOTFILES_HOME/ranger/utils
# Keyboard remaps
cp $HOME/.Xmodmap $DOTFILES_HOME/x
# Input configuration, touchpad etc
cp /etc/X11/xorg.conf.d/99-libinput.conf $DOTFILES_HOME/x
cp $HOME/.config/i3/config $DOTFILES_HOME/i3
cp $HOME/.config/i3/i3status.conf $DOTFILES_HOME/i3
cp $HOME/ShellScripts/brightness.sh $DOTFILES_HOME/i3
cp $HOME/ShellScripts/wmclass.sh $DOTFILES_HOME/i3
cp $HOME/.config/gtk-3.0/settings.ini $DOTFILES_HOME/gtk-3/settings.init
cp $HOME/.gtkrc-2.0 $DOTFILES_HOME/gtk-2/.gtkrc-2.0

cd $DOTFILES_HOME
git add .
git commit
echo "ready to push updated changes!"

