# Kill tomcat
function tomcat() {

    echo `ps -ef | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk '{ print $2 }' | tail -1`
    # echo "kill -9 $running_tomcats"
}
function cursor_mode() {
    # Source: https://thevaluable.dev/zsh-install-configure-mouseless/ 
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

function vimtextobjects() {
  # Add vim text objects for things like da", ci( etc
  # Source https://thevaluable.dev/zsh-install-configure-mouseless/ 
  autoload -Uz select-bracketed select-quoted
  zle -N select-quoted
  zle -N select-bracketed
  for km in viopp visual; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
      bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
      bindkey -M $km $c select-bracketed
    done
  done
}
# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# View man pages in Preview
function pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

function extract() {

	if [ -f "$1" ] ; then
         case "$1" in
             *.tar.bz2)   tar xvjf "$1"        ;;
             *.tar.gz)    tar xvzf "$1"     ;;
             *.bz2)       bunzip2 "$1"       ;;
             *.rar)       unrar x "$1"     ;;
             *.gz)        gunzip "$1"     ;;
             *.tar)       tar xvf "$1"        ;;
             *.tbz2)      tar xvjf "$1"      ;;
             *.tgz)       tar xvzf "$1"       ;;
             *.jar)       jar xf "$1"       ;;
             *.xz)        jar xf "$1"       ;;
             *.zip)       unzip "$1"     ;;
             *.Z)         uncompress "$1"  ;;
             *.7z)        7z x "$1"    ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

weather () {

    curl "http://wttr.in/$1";
}

function d2h() {
	printf "%X\n" $1
}

function unzipAll()
{
    for file in `ls | /bin/grep zip`; do 
        local base_name="${file%.*}"
        rm -rf $base_name 
        mkdir $base_name
        unzip $file -d $base_name
        rm $file
    done
}

function parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function fman() {
  sh ~/ShellScripts/fman.sh
}

function zz() {
  z "$@"
  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./venv ]] ; then
        source ./venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      local parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
        if [[ -d ./venv ]] ; then
          source ./venv/bin/activate
        fi
      fi
  fi
}

function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./venv ]] ; then
        source ./venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      local parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
        if [[ -d ./venv ]] ; then
          source ./venv/bin/activate
        fi
      fi
  fi
}

function resetdns() {
     dscacheutil -flushcache;
     sudo killall -HUP mDNSResponder
     sudo killall -9 mDNSResponder mDNSResponderHelper
     sudo launchctl stop homebrew.mxcl.dnsmasq 
     sudo launchctl start homebrew.mxcl.dnsmasq
}
