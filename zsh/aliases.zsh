# alias ls='ls -hG'
alias nn='fd --type=f | fzf-tmux -p | xargs nvim'
alias tree='ls --tree'
alias pdfcat='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=temp.pdf source*.pdf' # uses ghostscript
alias bloop='bloop-jvm'
alias less=bat
alias ls='COLUMNS=120 exa'
alias rustdocs="cargo doc --open"
alias godocs="echo 'Go Docs starting on http://localhost:3000' && godoc -http=:3000"
alias lg='lazygit'
alias myip='curl -s https://api.ipify.org | pbcopy'
alias tk='tmux kill-server'
alias pacfind="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Syu"
alias gwr='git worktree remove'
alias gwa='git worktree add'
alias bc='bc -l'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias ag='rg'
alias vi=nvim
alias vim=nvim
alias localip="hostname -I | cut -f1 -d' '"
alias dj='django-admin'
alias dirs="dirs -v" # Use cd ~dirnumber
alias smtp="java -jar $HOME/apps/fakeSMTP.jar -m -s -b -p 9999 -a 127.0.0.1"
alias json="jq '.'"
alias apksigninfo='jarsigner -verify -verbose -certs'
alias diskusage='du -sh * | sort -h'
alias youtubemusicmp3='youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'
alias youtubemusic='youtube-dl -f bestaudio --extract-audio'
alias yank='xclip -sel clip'
alias server='python3 -m http.server 8000'
alias prettyjson='python -m json.tool'
alias bounceterminal='echo -e "\a"'
alias mime='file --mime-type -b'
alias rm='rm -iv'
alias gs='git status'
alias venv='python3 -m venv'
alias python='python3'
alias pip='pip3'
alias py=python3
