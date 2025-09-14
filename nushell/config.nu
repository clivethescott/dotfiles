# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.EDITOR = 'nvim'
$env.XDG_CONFIG_HOME = $env.HOME | path join ".config" # important for Neovim
$env.XDG_DATA_HOME = $env.HOME | path join ".local/share"
$env.JIRA_PAGER = 'bat'
$env.JAVA_HOME = "/Library/Java/JavaVirtualMachines/graalvm-jdk-21.0.6+8.1/Contents/Home"
let GOBIN = $env.HOME | path join 'Code/Go/bin'
let JAVA_BIN = $env.JAVA_HOME | path join 'bin'
let COURSIER_BIN = $env.HOME | path join 'Library/Application\ Support/Coursier/bin'
let CARGO_BIN = $env.HOME | path join '.cargo/bin'
let APPS_BIN = $env.HOME | path join 'apps/bin'

use std/util "path add"
path add "/opt/homebrew/bin"
path add $GOBIN
path add $JAVA_BIN
path add $COURSIER_BIN
path add $CARGO_BIN

# Mise -- needs to be higher up
source ($nu.default-config-dir | path join mise.nu)

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
# mkdir ~/.cache/carapace
# carapace _carapace nushell | save --force ($nu.default-config-dir | path join carapace.nu)
source ($nu.default-config-dir | path join carapace.nu)

let vendor_autoload = ($nu.data-dir | path join "vendor/autoload")
mkdir $vendor_autoload

# Starship prompt
# starship init nu | save -f ($vendor_autoload | path join "starship.nu")
source starship.nu

alias lg = lazygit
alias gd = git diff
alias gs = git status
alias gp = git push
alias k = kubectl
alias kgetcontext = kubectl config current-context
alias ksetcontext = kubectl config use-context
# alias ksetnamespace  = kubectl config set-context --current --namespace=
alias dcli = dashlane dcli
alias jv = jira issue view
alias jless = jless --relative-line-numbers
alias yless = jless --relative-line-numbers --yaml
alias http = xh
alias z = cd
alias vim = nvim
alias nv = nvim
alias vi = nvim -u NONE
# alias ls = lsd
alias cat = bat
def gco [] {
  git branch | fzf --preview 'git show --color=always {-1}' --bind 'enter:become(git switch {-1})' --height 40% --layout reverse
}
alias py = python3
alias python = python3

$env.config.show_banner = false
$env.config.edit_mode = 'vi'
$env.config.cursor_shape = {
   emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
   vi_insert: line # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
   vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
}

# Atuin shell history
# https://docs.atuin.sh/configuration/key-binding/#nu
$env.ATUIN_NOBIND = true
# atuin init nu | save -f ~/.config/nushell/atuin.nu
# let atuin_path = $vendor_autoload | path join 'atuin.nu'
source ($nu.default-config-dir | path join atuin.nu)

$env._ZO_DATA_DIR = $env.XDG_CACHE_HOME
# zoxide init --cmd cd nushell | save -f ($nu.default-config-dir | path join zoxide.nu)
source ($nu.default-config-dir | path join zoxide.nu)

# https://www.nushell.sh/book/line_editor.html#keybindings
$env.config.keybindings ++= [
  {
    name: atuin
    modifier: control
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: { send: executehostcommand cmd: (_atuin_search_cmd) }
  },
  {
    name: complete_history
    modifier: control
    keycode: char_y
    mode: [emacs, vi_normal, vi_insert]
    event: { send: HistoryHintComplete }
  },
  {
    name: edit_command
    modifier: control
    keycode: char_e
    mode: [vi_normal, vi_insert]
    event: { send: OpenEditor }
  },
  {
    name: cut_to_line_start
    modifier: control
    keycode: char_u
    mode: [emacs, vi_insert]
    event: {edit: cutfromstart}
  },
  {
    name: cut_line_to_end
    modifier: control
    keycode: char_k
    mode: emacs
    event: {edit: cuttoend}
  },
  {
    name: zoxide_menu
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: zoxide_menu }
    ]
  },
]

