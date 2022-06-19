# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"
ZSH_TMUX_AUTOSTART=true

# Remove oldest history event that has a duplicate, if history needs trimming
HIST_EXPIRE_DUPS_FIRST="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"


# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Keep $PATH uniq
typeset -aU path

# Source this before applying tmux plugin
# Source this here and not in zshenv to prefix in $PATH
source $ZDOTDIR/exports.zsh

# Alt vi-mode plugin https://github.com/jeffreytse/zsh-vi-mode
plugins=(git vi-mode history-substring-search zsh-autosuggestions tmux)

# Path to your oh-my-zsh installation.
export ZSH=$ZDOTDIR/.oh-my-zsh

# Just offer a reminder every few days, if there are updates available
zstyle ':omz:update' mode reminder
# This will check for updates every X days
zstyle ':omz:update' frequency 30

source $ZSH/oh-my-zsh.sh

# User configuration
source $ZDOTDIR/setopt.zsh 
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/keybindings.zsh

# Switches cursor depending on vi mode
cursor_mode
# Additional vi-mode text objects
vimtextobjects


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### 
#
#Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# > FZF 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# File previews with Ctrl-T, --exit-0 automatically exits when the list is empty.
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always --line-range :200 {}) 2> /dev/null | head -200'"
# --preview option to display the full command on the preview window, ? toggles the preview window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude target --exclude venv --exclude .idea --exclude .jar --exclude .metals'
# Increase split window height, see fzf-tmux --help
export FZF_TMUX_OPTS="-d 60%"

# if you prefer to start in a tmux split pane
export FZF_TMUX=1
bindkey "^G" fzf-cd-widget
bindkey "^E" fzf-file-widget

# < FZF

# Make history searching work again after using vi mode
# bindkey "^[[A" history-substring-search-up
# bindkey "^[[B" history-substring-search-down
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down

# Disable Ctrl-S Flow control
stty -ixon
setopt noflowcontrol

# fpath+=${ZDOTDIR:-~}/.zsh_functions
# neofetch
#

# Increase the number of max open files/descriptions
ulimit -n 2048
eval "$(zoxide init zsh)"
