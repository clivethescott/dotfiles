export KEYTIMEOUT=50 # make zsh vi mode switch faster
export BROWSER=open
export EDITOR=nvim
export VISUAL=$EDITOR
export GOPATH=$HOME/Code/Go
export GOBIN=$GOPATH/bin
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND='rg --files'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=screen-256color

CARGO_HOME=$HOME/.cargo
APP_HOME=$HOME/apps
COURSIER_HOME=$HOME/Library/Application\ Support/Coursier
PYTHON_PATH=/opt/homebrew/opt/python@3.10
JENV_HOME=$HOME/.jenv

export PATH=/opt/homebrew/bin:$COURSIER_HOME/bin:$JENV_HOME/bin:$GOBIN:$PYTHON_PATH/bin:$CARGO_HOME/bin:$PATH


