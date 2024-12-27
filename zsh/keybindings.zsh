# use cat -v, to get keycodes
bindkey "\e\e[D" backward-word 
bindkey "\e\e[C" forward-word
bindkey "^G" fzf-cd-widget
bindkey "^E" fzf-file-widget
bindkey "^U" backward-kill-line
bindkey '^y' autosuggest-accept

bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down

bindkey '^[[A' history-substring-search-up # up key
bindkey '^[[B' history-substring-search-down # down key

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
