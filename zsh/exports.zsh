export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export KEYTIMEOUT=10 # make zsh vi mode switch faster
export BROWSER=open
export EDITOR=nvim
export VISUAL=$EDITOR
export GOPATH=~/Code/Go
export GOBIN=$GOPATH/bin
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND='rg --files'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=screen-256color
export XDG_CONFIG_HOME=$HOME/.config
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/21/libexec/openjdk.jdk/Contents/Home
export HOMEBREW_NO_ANALYTICS=1
export HISTSIZE=50000

CARGO_HOME=$HOME/.cargo
APP_HOME=$HOME/apps
COURSIER_HOME=$HOME/Library/Application\ Support/Coursier
PYTHON_PATH=/opt/homebrew/opt/python@3.11

export PATH=/opt/homebrew/bin:$JAVA_HOME/bin:$COURSIER_HOME/bin:$GOBIN:$PYTHON_PATH/bin:$CARGO_HOME/bin:$PATH


