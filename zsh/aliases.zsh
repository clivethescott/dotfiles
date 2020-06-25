alias macroip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paas-switch"
alias macro="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paas-switch | yank"
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias devtools='flutter pub global run devtools'
alias ag='rg'
alias genjson='flutter packages pub run build_runner build'
alias vim='nvim'
alias localip="hostname -I | cut -f1 -d' '"
alias dj='django-admin'
alias rabbitmqstart="docker run -it --rm --hostname rabbitmq --name rabbitmq --mount source=rabbitmq,target=/var/lib/rabbitmq -p 15672:15672 -p 5672:5672 rabbitmq:3-management"
alias rabbitmqstartdaemon="docker run -d --hostname rabbitmq --name rabbitmq --mount source=rabbitmq,target=/var/lib/rabbitmq -p 15672:15672 -p 5672:5672 rabbitmq:3-management"
#alias copytopr2="for j in `find . -name 'payment-gateway*.jar' -o -name 'payment-gateway*.war'`; sshpass -p 'developer@@' scp $j developer@192.168.106.4:/home/developer/deployment;"
alias dirs="dirs -v" # Use cd ~dirnumber
alias keycloak='docker run -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin -p 8080:8080 -it jboss/keycloak'
alias smtp='java -jar /home/clive/apps/fakeSMTP.jar -m -s -b -p 9999 -a 127.0.0.1'
alias sshcopy='ssh-copy-id -i ~/.ssh/id_rsa.pub user@host'
alias fix='ibus-daemon -rd'
alias u8='sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y'
alias py=python3
alias json="jq '.'"
alias apksigninfo='jarsigner -verify -verbose -certs'
alias diskusage='du -sh * | sort -h'
alias mavendownload='mvn dependency:go-offline'
alias youtubemusicmp3='youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'
alias youtubemusic='youtube-dl -f bestaudio --extract-audio'
alias yank='xclip -sel clip'
alias server='python3 -m http.server 8000'
alias vi=vim
alias ls='ls -hG --color=auto'
alias mc="mvn clean package -DskipTests"
alias prettyjson='python -m json.tool'
alias j8='source ~/java8.sh'
alias grep='grep --color=auto'
alias java6='export JAVA_HOME=$JAVA6_HOME'
alias bounceterminal='echo -e "\a"'
alias mime='file --mime-type -b'
alias gitpullcheck='git remote update && git status -uno'
alias updatepython='pip-review --local --interactive'
alias rm='rm -iv'
alias updatenode='ncu -u'
alias gs='git status'
alias venv='python3 -m venv'
alias mvn8='JAVA_HOME=/home/clive/apps/JDK/jdk1.8.0_151 mvn'
