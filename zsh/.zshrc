#
# Source this before applying tmux plugin
# Source this here and not in zshenv to prefix in $PATH
source $ZDOTDIR/exports.zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
# brew install zsh-vi-mode
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source $ZDOTDIR/setopt.zsh 
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh

if [[ -f "$ZDOTDIR/tokens.zsh" ]]; then
  source $ZDOTDIR/tokens.zsh
fi

# if [[ -n "$AWS_PROFILE" ]]; then
#   PROMPT+="$(aws_prof) ${editor_info[testing]}"
# fi
# Switches cursor depending on vi mode
cursor_mode
# Additional vi-mode text objects
vimtextobjects

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

# > FZF 
# File previews with Ctrl-T, --exit-0 automatically exits when the list is empty.
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)

# Allows <Tab> / <S-Tab> multiple selections
export FZF_DEFAULT_OPTS="-m --preview '(bat --color=always --line-range :50 {}) 2> /dev/null' "
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

source $ZDOTDIR/keybindings.zsh

# Disable Ctrl-S Flow control
stty -ixon
setopt noflowcontrol

# Increase the number of max open files/descriptions
ulimit -n 2048
eval "$(zoxide init zsh)"

# opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null
