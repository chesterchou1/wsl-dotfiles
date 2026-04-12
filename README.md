# WSL Dotfiles

My WSL2 terminal setup: yazi, tmux, lazygit, starship, and bash config.

## What's included

| Tool | Config path | Description |
|------|------------|-------------|
| **yazi** | `~/.config/yazi/` | File manager — vim keys, Google Material dark theme, git integration |
| **tmux** | `~/.tmux.conf` | Prefix `C-a`, vi mode, WSL clipboard, acrylic status bar, TPM plugins |
| **starship** | `~/.config/starship.toml` | Minimal prompt with git, language versions, cmd duration |
| **bash** | `~/.bashrc` | ble.sh, zoxide, fzf, atuin, modern aliases (eza, bat, lazygit) |

## Theme

Google Material dark palette across all tools:

- Base: `#1e1f22` / Glass: `#2a2b2f` / Highlight: `#3c4043`
- Blue `#8ab4f8` / Green `#81c995` / Yellow `#fdd663` / Red `#f28b82` / Magenta `#c58af9` / Cyan `#78d9ec`

## Dependencies

```
yazi eza bat fd ripgrep fzf zoxide atuin starship tmux lazygit neovim
```

Install via Homebrew (linuxbrew):
```bash
brew install yazi eza bat fd ripgrep fzf zoxide atuin starship tmux lazygit neovim
```

## Yazi plugins

The following yazi plugins are used (install via `ya pack`):
- `full-border` — full frame border around panes
- `smart-enter` — enter dir or open file
- `smart-paste` — smart paste behavior
- `smart-filter` — smart filter
- `jump-to-char` — jump to character
- `git` — git status markers

## Install

```bash
git clone https://github.com/chesterchou1/wsl-dotfiles.git
cd wsl-dotfiles
./install.sh
```

## tmux plugins (TPM)

After installing, press `prefix + I` inside tmux to install plugins:
- tmux-resurrect (session save/restore)
- tmux-continuum (auto-save every 15 min)
- vim-tmux-navigator (seamless vim/tmux pane nav)
