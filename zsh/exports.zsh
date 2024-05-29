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
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=screen-256color
export XDG_CONFIG_HOME=$HOME/.config
export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home
export HOMEBREW_NO_ANALYTICS=1
export HISTSIZE=50000
export XDG_CONFIG_HOME=~/.config
export NVIM_SETUP=home
# tokyonight theme for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c8d3f5,bg:#222436,hl:#ff966c \
--color=fg+:#c8d3f5,bg+:#2f334d,hl+:#ff966c \
--color=info:#82aaff,prompt:#86e1fc,pointer:#86e1fc \
--color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d"

CARGO_HOME=$HOME/.cargo
APP_HOME=$HOME/apps
COURSIER_HOME=$HOME/Library/Application\ Support/Coursier
PYTHON_PATH=/opt/homebrew/opt/python@3.12

export PATH=/opt/homebrew/bin:$JAVA_HOME/bin:$COURSIER_HOME/bin:$GOBIN:$PYTHON_PATH/bin:$CARGO_HOME/bin:$PATH

fpath+=/opt/homebrew/share/zsh/site-functions
