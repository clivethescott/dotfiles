# Nushell counterpart to ../fish/config.fish.
# Keep integrations here: Nu loads vendor autoload files after config.nu, and
# old generated vendor files previously overrode these settings.

# Environment and executable paths

$env.EDITOR = 'nvim'
$env.COMPOSE_BAKE = 'true'
$env.DISABLE_TELEMETRY = '1'
$env.JIRA_PAGER = 'bat'
$env.BAT_THEME = 'Catppuccin Mocha'
$env.PYTHONGIL = '0'
$env.XDG_CONFIG_HOME = ($env.HOME | path join '.config')
$env.XDG_DATA_HOME = ($env.HOME | path join '.local/share')
$env.XDG_CACHE_HOME = ($env.XDG_CACHE_HOME? | default ($env.HOME | path join '.cache'))
$env.TEALDEER_CONFIG_DIR = ($env.XDG_CONFIG_HOME | path join 'tealdeer')
$env.RIPGREP_CONFIG_PATH = ($env.HOME | path join 'dotfiles/ripgrep/.ripgreprc')
$env.MANPAGER = "sh -c 'sed -u -e \"s/\\x1B\\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

if ('/usr/libexec/java_home' | path exists) {
    $env.JAVA_HOME = (^/usr/libexec/java_home -v 21 | str trim)
}

# Match Fish's tool paths, skipping directories that are not installed.
let tool_paths = [
    '/opt/homebrew/bin'
    '/opt/homebrew/opt/uutils-coreutils/libexec/uubin'
    '/opt/homebrew/opt/curl/bin'
    ($env.HOME | path join 'Code/Go/bin')
    ($env.HOME | path join 'Library/Application Support/Coursier/bin')
    ($env.HOME | path join '.cargo/bin')
    ($env.HOME | path join 'apps/bin')
    ($env.HOME | path join '.docker/bin')
    ($env.HOME | path join '.local/bin')
    ($env.HOME | path join '.local/share/nvim/mason/bin')
    ($env.HOME | path join '.ghcup/bin')
    '/opt/homebrew/opt/git/share/git-core/contrib/git-jump'
    '/Applications/WezTerm.app/Contents/MacOS'
]
let java_path = if ('JAVA_HOME' in $env) { [($env.JAVA_HOME | path join 'bin')] } else { [] }
$env.PATH = ($tool_paths | append $java_path | where {|p| $p | path exists } | append $env.PATH | uniq)

$env.FZF_DEFAULT_OPTS = ([
    '--layout reverse'
    '--tmux 80%'
    '--border'
    "--bind 'alt-i:toggle-preview'"
    "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    '--walker-skip .git,node_modules,target,.scala-build,.idea'
    '--color=bg:#14161b,fg:white,hl:white,bg+:#14161b,fg+:white,hl+:white'
] | str join ' ')
$env.FZF_DEFAULT_COMMAND = 'fd --type file --strip-cwd-prefix --follow --exclude .git'
$env.FZF_CTRL_T_COMMAND = $env.FZF_DEFAULT_COMMAND
$env.FZF_CTRL_T_OPTS = $env.FZF_DEFAULT_OPTS
$env._ZO_FZF_OPTS = $env.FZF_DEFAULT_OPTS

# Line editor and completions
$env.config.show_banner = false
$env.config.edit_mode = 'vi'
$env.config.cursor_shape = {emacs: line, vi_insert: line, vi_normal: block}
$env.config.completions.case_sensitive = false
$env.config.completions.algorithm = 'fuzzy'
$env.config.buffer_editor = 'nvim'

# Fish supplies external command completions, including the user's WezTerm
# completion file and Homebrew's vendor completions. Null lets Nu fall back
# to its own path completion when Fish has no candidates.
let fish_completer = {|place|
    let line = ($place.command | str join ' ')
    let matches = (^fish --command 'complete --do-complete=$argv[1]' -- $line | from tsv --flexible --noheaders --no-infer)
    if ($matches | is-empty) {
        null
    } else {
        $matches | each {|match|
            let unescaped = ($match.column0 | str replace --all '\ ' ' ')
            let value = if $unescaped != $match.column0 and ($unescaped | path exists) {
                $unescaped | to nuon
            } else {
                $match.column0
            }
            {value: $value, description: ($match.column1? | default '')}
        }
    }
}
$env.config.completions.external.completer = $fish_completer

# Prompt
# Match Fish's prompt_pwd: the last two directories stay whole and older
# components shrink to three characters. Colours match Catppuccin Macchiato.
def prompt-path [] {
    let pwd = $env.PWD
    let display = if $pwd == $env.HOME {
        '~'
    } else if ($pwd | str starts-with $'($env.HOME)/') {
        $pwd | str replace $env.HOME '~'
    } else {
        $pwd
    }
    let parts = ($display | path split)
    let count = ($parts | length)
    let shortened = ($parts | enumerate | each {|part|
        if $part.index < ($count - 2) and $part.item != '~' and $part.item != '/' {
            $part.item | str substring --grapheme-clusters 0..<3
        } else {
            $part.item
        }
    })
    if ($shortened | first) == '/' {
        if $count == 1 { '/' } else { $'/($shortened | skip 1 | str join "/")' }
    } else {
        $shortened | str join '/'
    }
}

$env.PROMPT_COMMAND = {||
    let status = ($env.LAST_EXIT_CODE? | default 0)
    let failure = if $status == 0 { '' } else { $"(ansi '#ed8796')[($status)](ansi reset)" }
    $"(ansi '#eed49f')(prompt-path)(ansi reset)($failure)"
}
$env.PROMPT_COMMAND_RIGHT = ''
let prompt_suffix = if (^id -u | str trim) == '0' { '# ' } else { '$ ' }
$env.PROMPT_INDICATOR = $prompt_suffix
$env.PROMPT_INDICATOR_VI_INSERT = $prompt_suffix
$env.PROMPT_INDICATOR_VI_NORMAL = $prompt_suffix

# Atuin: record commands and search history with Ctrl-R.
# Keep the hooks inline to avoid generated init files.
if (which atuin | is-not-empty) {
    if 'ATUIN_SESSION' not-in $env or 'ATUIN_SHLVL' not-in $env or $env.ATUIN_SHLVL != ($env.SHLVL? | default '') {
        $env.ATUIN_SESSION = (random uuid -v 7 | str replace -a '-' '')
        $env.ATUIN_SHLVL = ($env.SHLVL? | default '')
    }
    hide-env -i ATUIN_HISTORY_ID
    let atuin_pre_execution = {||
        if ($nu | get history-enabled?) == false { return }
        let cmd = (commandline)
        if ($cmd | is-empty) or ($cmd in ['atuin_search' 'tv_smart_autocomplete']) { return }
        $env.ATUIN_HISTORY_ID = (with-env {ATUIN_SHELL: nu} {
            atuin history start --hook -- $cmd | complete | get stdout | str trim
        })
    }
    let atuin_pre_prompt = {||
        if 'ATUIN_HISTORY_ID' not-in $env { return }
        let last_exit = $env.LAST_EXIT_CODE
        do { ^atuin history end --hook $'--exit=($last_exit)' -- $env.ATUIN_HISTORY_ID } | complete | ignore
        hide-env -i ATUIN_HISTORY_ID
    }
    $env.config.hooks.pre_execution ++= [$atuin_pre_execution]
    $env.config.hooks.pre_prompt ++= [$atuin_pre_prompt]
}

def atuin_search [] {
    let original = (commandline)
    let output = (with-env {ATUIN_QUERY: $original, ATUIN_SHELL: nu} {
        run-external atuin search '--interactive' e>| str trim
    })
    if ($output | str starts-with '__atuin_accept__:') {
        commandline edit --accept ($output | str replace '__atuin_accept__:' '')
    } else if $output != '' {
        commandline edit $output
    }
}
if (which atuin | is-not-empty) {
    $env.config.keybindings ++= [{
        name: atuin
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: {send: executehostcommand, cmd: 'atuin_search'}
    }]
}

# Television: Ctrl-T completes the current argument using its picker.
# Its history binding is omitted so Atuin owns Ctrl-R in every edit mode.
def tv_smart_autocomplete [] {
    let line = (commandline)
    let cursor = (commandline get-cursor)
    let lhs = ($line | str substring 0..$cursor)
    let rhs = ($line | str substring $cursor..)
    let output = (tv --no-status-bar --inline --autocomplete-prompt $lhs | str trim)
    if ($output | str length) > 0 {
        let lhs_with_space = if ($lhs | str ends-with ' ') { $lhs } else { $"($lhs) " }
        commandline edit --replace ($lhs_with_space + $output + $rhs)
        commandline set-cursor ($lhs_with_space + $output | str length)
    }
}
if (which tv | is-not-empty) {
    $env.config.keybindings ++= [{
        name: tv_completion
        modifier: control
        keycode: char_t
        mode: [emacs, vi_normal, vi_insert]
        event: {send: executehostcommand, cmd: 'tv_smart_autocomplete'}
    }]
}

# Zoxide: track directories and make `cd keyword` search the Fish zoxide DB.
if (which zoxide | is-not-empty) {
    $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD? | default [] | append {|_, dir| ^zoxide add -- $dir})
}
def --env --wrapped __zoxide_cd [...rest: directory] {
    let target = match $rest {
        [] => '~'
        ['-'] => '-'
        [$arg] if ($arg | path expand | path type) == 'dir' => $arg
        _ => (^zoxide query --exclude $env.PWD -- ...$rest | str trim -r -c "\n")
    }
    cd $target
}
def --env --wrapped cdi [...rest: string] {
    cd (^zoxide query --interactive -- ...$rest | str trim -r -c "\n")
}
alias cd = __zoxide_cd

# Abbreviations
# Native REPL abbreviations expand visibly on Space or Enter, like Fish.
# Keep `ls` native for table output; call `lsd` directly when wanted.
$env.config.abbreviations = {
    g: 'git branch; git status --short'
    gb: 'git branch'
    gd: 'git diff'
    gs: 'git status'
    gp: 'git pull --ff --quiet'
    gr: 'git restore .'
    gP: 'git push'
    gw: 'git worktree'
    gwl: 'git worktree list'
    gwr: 'git worktree remove'
    gwa: 'git worktree add'
    unset: 'hide-env'
    pbclear: 'open --raw /dev/null | pbcopy'
    cl: 'claude agents'
    cdr: 'cd (git rev-parse --show-toplevel | str trim)'
    sbtd: 'sbt -Dsbt.server.autostart=false'
    tldr: 'tldr -p macos --pager'
}

# Only advertise shortcuts for optional programs that are installed.
let optional_abbreviations = [
    {program: tv,         entries: {t: tv}}
    {program: gron,       entries: {ungron: 'gron --ungron'}}
    {program: lazygit,    entries: {lg: lazygit}}
    {program: lazydocker, entries: {lld: lazydocker}}
    {program: dcli,       entries: {dashlane: dcli}}
    {program: jless,      entries: {jless: 'jless --relative-line-numbers', yless: 'jless --relative-line-numbers --yaml'}}
    {program: terraform,  entries: {tf: terraform}}
    {program: gitui,      entries: {gt: gitui}}
    {program: xh,         entries: {http: xh}}
    {program: nvim,       entries: {vim: nvim, nv: nvim, nvi: nvim, vi: 'nvim -u NONE'}}
    {program: bat,        entries: {cat: bat}}
    {program: ast-grep,   entries: {sg: ast-grep}}
    {program: gh,         entries: {ghr: 'gh pr checkout'}}
    {program: python3,    entries: {py: python3, python: python3}}
    {program: opencode,   entries: {oc: opencode}}
    {program: uv,         entries: {pip: 'uv pip', pip3: 'uv pip'}}
    {program: zoxide,     entries: {z: cdi}}
]
for item in $optional_abbreviations {
    if (which $item.program | is-not-empty) {
        $env.config.abbreviations = ($env.config.abbreviations | merge $item.entries)
    }
}

# Kubernetes uses different expansions depending on whether kubens is present.
if (which kubectl | is-not-empty) {
    $env.config.abbreviations = ($env.config.abbreviations | merge {k: kubectl, kgetcontext: 'kubectl config current-context'})
    if (which kubens | is-not-empty) {
        $env.config.abbreviations = ($env.config.abbreviations | merge {kn: kubens, kx: 'kubectx; kubens'})
    } else {
        $env.config.abbreviations = ($env.config.abbreviations | merge {kn: 'kubectl config set-context --current --namespace=', kx: 'kubectl config use-context'})
    }
}

# Extra Git helpers
def gco [] {
    let branch = (git branch --format='%(refname:short)' | fzf --preview 'git show --color=always {}' --height 40% --layout reverse | str trim)
    if $branch != '' { git switch $branch }
}

# JC parses full messages; the default view keeps the terminal table compact.
# Examples: glog -n 10 --author Alice; glog --full | where author =~ 'Clive'.
def --wrapped glog [--limit(-n): int = 20, --full(-f), ...args: string] {
    let commits = (
        ^git log $'--max-count=($limit)' ...$args
        | ^jc --git-log
        | from json
        | update date {|row| $row.date | into datetime}
    )
    if $full {
        $commits
    } else {
        $commits
        | select commit date author message
        | rename hash date author subject
        | update hash {|row| $row.hash | str substring 0..<7}
        | update subject {|row| $row.subject | lines | first 1 | str join ''}
    }
}

# Editing shortcuts carried over from Fish's vi mode.
$env.config.keybindings ++= [
    {
        name: history_hint
        modifier: control
        keycode: char_y
        mode: [emacs, vi_normal, vi_insert]
        event: {send: HistoryHintComplete}
    }
    {
        name: edit_command
        modifier: control
        keycode: char_e
        mode: [vi_normal, vi_insert]
        event: {send: OpenEditor}
    }
    {
        name: cut_to_start
        modifier: control
        keycode: char_u
        mode: [emacs, vi_insert]
        event: {edit: cutfromstart}
    }
    {
        name: cut_to_end
        modifier: control
        keycode: char_k
        mode: emacs
        event: {edit: cuttoend}
    }
]
