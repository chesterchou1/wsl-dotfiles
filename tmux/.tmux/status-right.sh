#!/usr/bin/env bash
# tmux status-right segments: git (conditional) + battery.
# One shell invocation instead of several, faster + cleaner.
#
# Usage: status-right.sh <pane_current_path>

set -u
cwd="${1:-$PWD}"

# Palette (Google Material dark — matches WezTerm)
FG_DIM="#[fg=#5f6368]"
FG_MUTED="#[fg=#9aa0a6]"
FG_BRANCH="#[fg=#f28b82]"
FG_COMMIT="#[fg=#81c995]"
FG_BAT_OK="#[fg=#81c995]"
FG_BAT_MID="#[fg=#fdd663]"
FG_BAT_LOW="#[fg=#f28b82]"
FG_BAT_CHG="#[fg=#8ab4f8]"
RESET="#[default]"

out=""

# --- Git segment (only when inside a work tree) -----------------------------
if cd "$cwd" 2>/dev/null && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  # Dirty indicator
  if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    dirty=" ✗"
  else
    dirty=""
  fi
  commit=$(git log -1 --format='%s' 2>/dev/null | cut -c1-25)
  out+="${FG_BRANCH} ${branch}${dirty} ${FG_DIM}· ${FG_COMMIT}${commit} ${FG_DIM}│ "
fi

# --- Battery segment --------------------------------------------------------
bat_dir=""
for d in /sys/class/power_supply/BAT*; do
  [[ -d "$d" ]] && bat_dir="$d" && break
done

if [[ -n "$bat_dir" ]]; then
  cap=$(<"$bat_dir/capacity")
  status=$(<"$bat_dir/status")

  # Icon ramp — nf-md-battery_*
  if [[ "$status" == "Charging" || "$status" == "Full" ]]; then
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
  out+="${color}${icon} ${cap}%${RESET}"
fi

printf '%s' "$out"
