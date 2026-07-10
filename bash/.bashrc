# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ── ble.sh early init (lazy: only load when BLE_ENABLE=1) ──
# ble.sh adds ~300-500ms to shell startup. Disabled by default for speed.
# Enable per-session with: BLE_ENABLE=1 bash
if [[ "${BLE_ENABLE:-0}" == "1" && -f ~/.local/share/blesh/ble.sh ]]; then
  source ~/.local/share/blesh/ble.sh --noattach
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# (ls aliases removed — overridden by eza aliases below)

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# ── Homebrew ──
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ── Trim Windows PATH interop: keep only the useful Windows dirs ──
# Windows injects ~20 /mnt/c/* entries that pollute tab-completion and slow
# startup. Drop them all, then re-add the handful that hold tools we actually
# call from WSL (powershell, explorer, winget/Store apps, code if installed).
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  win_keep=(
    "/mnt/c/Windows/system32"
    "/mnt/c/Windows"
    "/mnt/c/Windows/System32/Wbem"
    "/mnt/c/Windows/System32/WindowsPowerShell/v1.0"
    "/mnt/c/Windows/System32/OpenSSH"
    "/mnt/c/Users/$USER/AppData/Local/Microsoft/WindowsApps"
    "/mnt/c/Users/$USER/AppData/Local/Programs/Microsoft VS Code/bin"
    "/mnt/c/Program Files/Microsoft VS Code/bin"
  )
  clean_path=""
  IFS=':' read -ra _segs <<< "$PATH"
  for _s in "${_segs[@]}"; do
    case "$_s" in /mnt/c/*) ;; *) clean_path="${clean_path:+$clean_path:}$_s" ;; esac
  done
  for _w in "${win_keep[@]}"; do
    [[ -d "$_w" ]] && clean_path="${clean_path:+$clean_path:}$_w"
  done
  export PATH="$clean_path"
  unset clean_path _segs _s _w win_keep
fi

# ── SSH Agent (start once per session) ──
if [[ -z "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)" >/dev/null 2>&1
fi
export GPG_TTY=$(tty)

# ── Tool init (with guard clauses) ──
command -v zoxide  >/dev/null && eval "$(zoxide init bash)"
command -v fzf     >/dev/null && eval "$(fzf --bash)"
command -v atuin   >/dev/null && eval "$(atuin init bash --disable-up-arrow)"
command -v starship >/dev/null && eval "$(starship init bash)"

# ── Modern aliases ──
alias ls='eza --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias ll='eza --tree --icons --level=2'
alias cat='bat --paging=never'
alias lg='lazygit'

# ── AI tools ──
alias cc='claude'
alias cx='codex'

# ── Work Logger (v2 — WSL repo) ──
wl() { python3 /home/chester_chou/workspace/work-logger/work_logger.py "$@"; }
[[ -f /home/chester_chou/workspace/work-logger/bin/wl-completion.bash ]] && \
  source /home/chester_chou/workspace/work-logger/bin/wl-completion.bash


# ── Per-user overrides (git identity, work aliases, env vars) ──
# Create ~/.bashrc.local on each user account for user-specific config.
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# ── ble.sh attach (must be last, only if loaded) ──
[[ ${BLE_VERSION-} ]] && ble-attach

# tmux session picker (fzf): kill multiple
tks() {
  tmux ls -F '#{session_name}' 2>/dev/null \
    | fzf -m --preview 'tmux capture-pane -ept {} 2>/dev/null' \
    | xargs -r -n1 tmux kill-session -t
}

# tmux session picker (fzf): switch/attach
tss() {
  local s
  s=$(tmux ls -F '#{session_name}' 2>/dev/null \
    | fzf --preview 'tmux capture-pane -ept {} 2>/dev/null')
  [ -z "$s" ] && return
  tmux switch-client -t "$s" 2>/dev/null || tmux attach -t "$s"
}

# ── Yazi wrapper: cd into the dir shown when Yazi quits (press `q`). ──
y() {
  local tmp cwd
  tmp=$(mktemp -t "yazi-cwd.XXXXXX") || return
  yazi "$@" --cwd-file="$tmp"
  if cwd=$(cat -- "$tmp") && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd" || return
  fi
  rm -f -- "$tmp"
}

# Use system CA bundle so tools trust the Compal Check Point proxy root
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export SSL_CERT_DIR=/etc/ssl/certs

# Open the most recent ShareX screenshot in the default Windows viewer
shot() {
  local latest
  latest=$(find /mnt/d/screenshots -maxdepth 3 -type f \
    \( -iname '*.png' -o -iname '*.jpg' \) -printf '%T@ %p\n' 2>/dev/null \
    | sort -nr | head -1 | cut -d' ' -f2-)
  if [[ -z "$latest" ]]; then
    echo "no screenshots found in /mnt/d/screenshots" >&2
    return 1
  fi
  echo "$latest"
  explorer.exe "$latest"
}

# Import the current Windows clipboard image into WSL as a PNG file.
paste-shot() {
  local out dir win_out ps
  out="${1:-./pasted-shot-$(date +%Y%m%d-%H%M%S).png}"
  dir=$(dirname "$out")
  mkdir -p "$dir" || return 1

  if [[ "$out" != *.png ]]; then
    out="${out}.png"
  fi

  ps="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
  if [[ ! -x "$ps" ]]; then
    echo "powershell.exe not found at $ps" >&2
    return 1
  fi

  win_out=$(wslpath -w "$out") || return 1
  WIN_OUT="$win_out" "$ps" -STA -NoProfile -NonInteractive -Command '
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $img = [System.Windows.Forms.Clipboard]::GetImage()
    if ($null -eq $img) {
      Write-Error "No image found in the Windows clipboard."
      exit 2
    }

    $target = $env:WIN_OUT
    $parent = Split-Path -Parent $target
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
      New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    try {
      $img.Save($target, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
      $img.Dispose()
    }
  ' || return $?

  printf '%s\n' "$(realpath "$out")"
}

# ── Bitwarden CLI ──
# bwu: unlock the vault and export BW_SESSION into the current shell so
# subsequent `bw` commands don't re-prompt. `bwl`: lock + clear the session.
bwu() {
  local status
  status=$(bw status 2>/dev/null | grep -o '"status":"[^"]*"' | cut -d'"' -f4)
  case "$status" in
    unlocked) echo "bw: already unlocked" ;;
    locked)         BW_SESSION=$(bw unlock --raw) && export BW_SESSION || return 1 ;;
    unauthenticated|"") BW_SESSION=$(bw login --raw) && export BW_SESSION || return 1 ;;
    *) echo "bw: unknown status '$status'" >&2; return 1 ;;
  esac
}
bwl() {
  bw lock >/dev/null 2>&1
  unset BW_SESSION
  echo "bw: locked"
}

# Trust Compal Check Point corporate CA so Node/Claude Code work on intra network
export NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/compal-checkpoint.crt
[06/29/26 17:51:47] INFO     WorkLogger initialized                              logger.py:91
# wl shell completion — generated by `wl completions bash`
# Source this file or append to ~/.bashrc:
#   wl completions bash >> ~/.bashrc

_wl_completions()
{
    local cur prev words cword
    _init_completion || return

    # First word: complete actions + aliases
    if [[ $cword -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "break completions config delete edit export in log lunch mood note open out report resume status sync tidy todo tree" -- "$cur") )
        return
    fi

    # Second word: sub-action / flag hints
    case "${words[1]}" in
        break|lunch|resume|in|out|status|tree|config)
            COMPREPLY=( $(compgen -W "-n --notes" -- "$cur") )
            ;;
        report|export)
            COMPREPLY=( $(compgen -W "-d --days --from --to --week --month --summary --digest -m --mode --date -f --format" -- "$cur") )
            ;;
        note)
            COMPREPLY=( $(compgen -W "list search rm clean -p --project -n --notes --tags -s --scaffold -S --scope --date -d --days --tag -o --open" -- "$cur") )
            ;;
        log)
            COMPREPLY=( $(compgen -W "-p --project -n --notes --tags" -- "$cur") )
            ;;
        todo)
            COMPREPLY=( $(compgen -W "done rm all -p --project -n --notes --tags" -- "$cur") )
            ;;
        mood)
            COMPREPLY=( $(compgen -W "1 2 3 4 5 great good ok low bad -d --days" -- "$cur") )
            ;;
        sync)
            COMPREPLY=( $(compgen -W "gcal projects -p --project --date -d --days --week --month --from --to -o --open" -- "$cur") )
            ;;
        open)
            COMPREPLY=( $(compgen -W "sum inbox review vault -p --project --date -d --days --catchup --model" -- "$cur") )
            ;;
        edit)
            COMPREPLY=( $(compgen -W "--id --set" -- "$cur") )
            ;;
        delete)
            COMPREPLY=( $(compgen -W "--id" -- "$cur") )
            ;;
        tidy)
            COMPREPLY=( $(compgen -W "triage promote connect --dry-run" -- "$cur") )
            ;;
        completions)
            COMPREPLY=( $(compgen -W "bash zsh fish" -- "$cur") )
            ;;
    esac
}

complete -F _wl_completions wl

