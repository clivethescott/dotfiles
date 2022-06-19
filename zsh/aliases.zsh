# alias ls='ls -hG'
alias bloop='bloop-jvm'
alias bu='brew upgrade neovim --fetch-head && vim -c ":PackerSync"'
alias less=bat
alias ls='COLUMNS=120 exa'
alias grep='rg'
alias find='fd'
alias ps='procs'
alias rustdocs="cargo doc --open"
alias godocs="echo 'Go Docs starting on http://localhost:3000' && godoc -http=:3000"
alias lg='lazygit'
alias myip='curl -s https://api.ipify.org | pbcopy'
alias tk='tmux kill-server'
alias fpb='flutter pub get'
alias pacfind="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Syu"
alias exe='exercism'
alias rn='ranger'
alias luamake=/home/clive/apps/lua-language-server/3rd/luamake/luamake
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias gwr='git worktree remove'
alias gwa='git worktree add'
alias jbl="bluetooth_battery 'B8:F6:53:57:AD:D5"
alias fpg='flutter pub get'
# alias tmux='tmux attach || tmux new-sesssion'
alias aliases='nvim ~/.zsh/aliases.zsh'
alias rr=ranger
alias disablewebcam='sudo modprobe -r uvcvideo'
alias mvnr='mvn spring-boot:run -Drun.jvmArguments="-Xms1G -Xmx1G"'
alias bc='bc -l'
alias adbu='adb uninstall zw.gov.mohcc.mrs.ehr_mobile'
# alias code=codium
alias fr='flutter run'
alias frn='flutter run --no-sound-null-safety'
alias ehrdump="docker exec mysql sh -c 'exec mysqldump --all-databases -uroot'"
alias c='clear'
alias gencoverage='coverage run --source='.' manage.py test && coverage html'
alias macroip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paas-switch"
alias macro="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paas-switch | yank"
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias devtools='flutter pub global run devtools'
alias ag='rg'
alias gen='flutter packages pub run build_runner build --delete-conflicting-outputs'
alias genw='flutter packages pub run build_runner watch --delete-conflicting-outputs'
alias vim='nvim'
alias localip="hostname -I | cut -f1 -d' '"
alias dj='django-admin'
alias dirs="dirs -v" # Use cd ~dirnumber
alias smtp='java -jar /home/clive/apps/fakeSMTP.jar -m -s -b -p 9999 -a 127.0.0.1'
alias sshcopy='ssh-copy-id -i ~/.ssh/id_rsa.pub user@host'
alias fix='ibus-daemon -rd'
# alias u8='sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y'
alias u8='sudo pacman -Syu'
alias json="jq '.'"
alias apksigninfo='jarsigner -verify -verbose -certs'
alias diskusage='du -sh * | sort -h'
alias mavendownload='mvn dependency:go-offline'
alias youtubemusicmp3='youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'
alias youtubemusic='youtube-dl -f bestaudio --extract-audio'
alias yank='xclip -sel clip'
alias server='python3 -m http.server 8000'
alias vi=vim
alias mr='mvn spring-boot:run -Drun.jvmArguments="-Xms1G -Xmx1G"'
alias mc='mvn clean install && cd mrs-web && mr'
alias prettyjson='python -m json.tool'
# alias grep='grep --color=auto'
alias bounceterminal='echo -e "\a"'
alias mime='file --mime-type -b'
alias gitpullcheck='git remote update && git status -uno'
alias updatepython='pip-review --local --interactive'
alias rm='rm -iv'
alias gs='git status'
alias venv='python3 -m venv'
alias python='python3'
alias pip='pip3'
alias py=python3
