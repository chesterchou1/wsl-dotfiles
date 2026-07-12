#!/usr/bin/env bash
# tmux status-right segments: git (conditional) + battery.
# One shell invocation instead of several, faster + cleaner.
#
# Rhythm rule: every optional segment prints its own trailing "│ ", so
# the standalone clock in .tmux.conf never has to guess what sits in
# front of it (no double-pipe when a segment goes quiet).
#
# Usage: status-right.sh <pane_current_path>

set -u
cwd="${1:-$PWD}"

# Palette (Windows Terminal "Google Dark" scheme)
# Grey carries identity, color carries state: the branch name is neutral
# grey and only the dirty dot gets a color.
FG_BRANCH="#[fg=#A0A0A0]"
FG_DIRTY="#[fg=#E06070]"
FG_BAT_OK="#[fg=#50C878]"
FG_BAT_MID="#[fg=#E0C060]"
FG_BAT_LOW="#[fg=#F08090]"
FG_BAT_CHG="#[fg=#8A8A8A]"   # grey — blue stays reserved for copy/zoom
RESET="#[default]"
SEP="#[fg=#404040]│ "

out=""

# --- Git segment (cached to avoid repeated subprocess calls) ----------------
# Cache git info for 10 seconds per working directory to prevent lag in large repos.
_git_cache_dir="/tmp/tmux-git-cache"
mkdir -p "$_git_cache_dir" 2>/dev/null
_git_cache_key=$(printf '%s' "$cwd" | md5sum | cut -d' ' -f1)
_git_cache_file="$_git_cache_dir/$_git_cache_key"

_cache_fresh=0
if [[ -f "$_git_cache_file" ]]; then
  _cache_age=$(( $(date +%s) - $(stat -c%Y "$_git_cache_file") ))
  (( _cache_age < 10 )) && _cache_fresh=1
fi

if (( _cache_fresh )); then
  out+=$(cat "$_git_cache_file")
else
  _git_seg=""
  if cd "$cwd" 2>/dev/null && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    # Dirty dot (limit scope for speed) — ● not ✗: uncommitted work isn't failure
    if [[ -n "$(git status --porcelain -uno 2>/dev/null | head -1)" ]]; then
      dirty=" ●"
    else
      dirty=""
    fi
    _git_seg="${FG_BRANCH} ${branch}${FG_DIRTY}${dirty} ${SEP}"
  fi
  printf '%s' "$_git_seg" > "$_git_cache_file"
  out+="$_git_seg"
fi

# --- Battery segment ----------------------------------------------------------
# Always visible. On AC (Full / Charging / ThinkPad "Not charging") the plug
# icon shows in neutral grey — blue stays reserved for copy/zoom. The color
# ramp only speaks while discharging.
bat_dir=""
for d in /sys/class/power_supply/BAT*; do
  [[ -d "$d" ]] && bat_dir="$d" && break
done

if [[ -n "$bat_dir" ]]; then
  cap=$(<"$bat_dir/capacity")
  status=$(<"$bat_dir/status")

  # Icon ramp — nf-md-battery_*
  if [[ "$status" != "Discharging" ]]; then
    icon="󰂄"
    color="$FG_BAT_CHG"
  else
    if   (( cap >= 90 )); then icon="󰁹"
    elif (( cap >= 80 )); then icon="󰂂"
    elif (( cap >= 70 )); then icon="󰂁"
    elif (( cap >= 60 )); then icon="󰂀"
    elif (( cap >= 50 )); then icon="󰁿"
    elif (( cap >= 40 )); then icon="󰁾"
    elif (( cap >= 30 )); then icon="󰁽"
    elif (( cap >= 20 )); then icon="󰁼"
    elif (( cap >= 10 )); then icon="󰁻"
    else                       icon="󰁺"
    fi
    if   (( cap >= 50 )); then color="$FG_BAT_OK"
    elif (( cap >= 20 )); then color="$FG_BAT_MID"
    else                       color="$FG_BAT_LOW"
    fi
  fi
  out+="${color}${icon} ${cap}%${RESET} ${SEP}"
fi

printf '%s' "$out"
