#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "  backup: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  linked: $dst -> $src"
}

echo "=== yazi ==="
for f in yazi.toml keymap.toml theme.toml init.lua; do
  link "$DOTFILES_DIR/yazi/$f" "$HOME/.config/yazi/$f"
done

echo "=== tmux ==="
link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES_DIR/tmux/.tmux/status-right.sh" "$HOME/.tmux/status-right.sh"

echo "=== starship ==="
link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

echo "=== bash ==="
link "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"

echo ""
echo "Done. Restart your shell or run: source ~/.bashrc"
