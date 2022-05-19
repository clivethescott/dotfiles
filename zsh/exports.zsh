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
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

APP_HOME=$HOME/apps
COURSIER_HOME=$HOME/Library/Application\ Support/Coursier
PYTHON_PATH=/opt/homebrew/opt/python@3.10

export PATH=$JAVA_HOME/bin:$COURSIER_HOME/bin:$GOBIN:/opt/homebrew/bin:$PYTHON_PATH/bin:$PATH

