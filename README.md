# WSL Dotfiles

A dark, minimal terminal environment for WSL2/Ubuntu running under WezTerm on Windows. Every tool shares a cohesive Google Material Dark-inspired color palette -- pure blacks, muted grays, and warm accent tones -- tuned for long sessions with low eye strain.

## Preview

<!-- Add a screenshot here -->
> ![terminal preview](screenshots/preview.png)
>
> *Replace with an actual screenshot of your setup.*

---

## What's Included

### WezTerm (`wezterm/.wezterm.lua`)

The host terminal emulator, running on the Windows side. This is the outermost layer of the stack.

- **Theme**: Custom Google Dark Material-inspired scheme with a pure black (`#000000`) background, muted foreground (`#a0a0a0`), and warm ANSI colors. The tab bar matches seamlessly -- black titlebar, subtle `#141414` active tab highlight, dim inactive tabs.
- **Font**: JetBrains Mono (Medium, 13pt, 1.2 line height) with Noto Color Emoji fallback. FreeType hinting disabled for clean rendering.
- **Leader key**: `Ctrl+b` with 1500ms timeout (tmux-style workflow).
- **Vim-style copy mode**: Full vi motions (`h/j/k/l`, `w/b/e`, `0/$`, `g/G`, `H/M/L`), visual/line/block selection (`v/V/Ctrl+v`), search (`/`, `n/N`), and yank-to-clipboard (`y`).
- **Smart vim/nvim passthrough**: Detects if the foreground process is vim or nvim (with result caching to prevent freezes) and forwards `Ctrl+h/j/k/l` navigation keys to vim instead of WezTerm pane switching.
- **WSL Ubuntu as default domain**: Launches directly into `WSL:Ubuntu` on startup, maximized.
- **Process icons**: Nerd Font icons for 30+ processes in tab titles -- shells (bash, zsh, pwsh, fish), editors (vim, nvim), languages (python, node, rust, go, lua), tools (git, lazygit, docker, kubectl, k9s, ssh, htop), databases (psql, mysql, redis-cli), and AI tools (claude).
- **Workspace support**: Create named workspaces (`Leader+Shift+W`), switch between them (`Leader+s`), with workspace name shown in the right status bar.
- **Quick select patterns**: `Leader+Space` activates quick select with patterns for git hashes, UUIDs, IPv4 addresses, email addresses, environment variables, Unix paths, and Windows paths.
- **Launch menu**: Quick access to PowerShell, CMD, Git Bash, WSL Ubuntu, Node REPL, Python, and Claude Code.
- **Hyperlink rules**: Clickable GitHub issue/PR references (`owner/repo#123`), `gh:owner/repo` shorthand, and `file://` URIs.
- **GPU rendering**: OpenGL front-end at 60fps, with integrated Windows title buttons.

### tmux (`tmux/.tmux.conf`, `tmux/.tmux/status-right.sh`)

Session and window management inside WSL.

- **Prefix**: `Ctrl+a` (rebound from default `Ctrl+b`)
- **Vi mode**: Copy-mode with `v` for selection, `C-v` for rectangle toggle, `y`/Enter to yank to Windows clipboard via `clip.exe`
- **Pane navigation**: Vim-style `h/j/k/l` with repeatable resize via `H/J/K/L`
- **Splits**: `|` for horizontal, `-` for vertical (preserving current path)
- **Floating popups**: `p` for a shell popup, `f` for a yazi file manager popup, `S` for fzf session picker, `X` for fzf session killer
- **Context menus**: `w` for window actions menu (new, split, zoom, rename, kill), `g` for workspace actions menu (browse, move, join, swap, detach, kill)
- **Status bar**: Google Material dark "frosted acrylic" style with pill-shaped segments. Left shows session name (blue, yellow on prefix, green in copy mode), window/pane counts. Right shows prefix/zoom indicators, git branch + dirty status + last commit message, and battery level with icon ramp.
- **Window tabs**: Frosted pill style with command suffix (shows the running process when it is not just a shell)
- **Plugins (TPM)**: tmux-resurrect (session persistence), tmux-continuum (auto-save every 15 min, auto-restore), vim-tmux-navigator (seamless vim/tmux pane navigation)
- **Sensible defaults**: 256-color + RGB, clipboard passthrough, image protocol passthrough (for yazi previews), zero escape time, 50k scrollback, mouse on, base index 1, aggressive resize

### Starship (`starship/starship.toml`)

A minimal, informative shell prompt.

- **Format**: `user@host dir git_branch git_status [languages] cmd_duration` on line 1, then `>` on line 2
- **Git**: Branch in purple, status (dirty/ahead/behind) in red
- **Language detection**: Python, Node.js, Rust, Go, Docker context -- shown only when relevant files are present
- **Command duration**: Displayed in yellow when a command takes longer than 2 seconds
- **Character**: Green `>` on success, red `>` on error

### Yazi (`yazi/`)

A terminal file manager with vim-style navigation and deep theming.

- **Theme** (`theme.toml`): Full Google Material dark palette. Blue accents for directories and borders, yellow for selections and warnings, red for deletions, green for additions, magenta for images, cyan for info. Nerd Font icons for directories, file types, and common config files.
- **Navigation** (`keymap.toml`): `h/l` to navigate parent/child, `g+h/c/t/d//` for quick jumps to home, config, tmp, downloads, root. Tabs via `t`/Tab/Shift-Tab.
- **File operations**: `y` copies files and writes paths to Windows clipboard via `clip.exe`, `x` cuts, `p/P` pastes (with overwrite option), `D` trashes, `Ctrl+d` permanently deletes, `a` creates, `r` renames.
- **Search**: `/` for smart find, `f/F` for filter, `s` to search by filename (fd), `S` to search by content (rg)
- **View modes**: `.` toggles hidden files, `,+s/m/p/n` switches line mode (size, mtime, permissions, none)
- **Config** (`yazi.toml`): 1:3:4 pane ratio, natural sort with directories first, nvim as editor, `wslview` for opening files on the Windows side, markdown preview via glow plugin, git status fetcher
- **Plugins** (`init.lua`): full-border (frame around panes), git (status markers with Material palette colors)

### Bash (`bash/.bashrc`)

Shell configuration with modern tooling.

- **ble.sh**: Syntax highlighting and autocompletion for bash (early init + late attach pattern)
- **Zoxide**: Smart `cd` replacement (`z` command, learns from usage)
- **fzf**: Fuzzy finder integration for files and history
- **Atuin**: Enhanced shell history with search (replaces Ctrl+R, up-arrow preserved)
- **Starship**: Prompt initialization
- **Modern aliases**: `ls` -> `eza` (with icons), `cat` -> `bat`, `ll` -> `eza --tree`, `lg` -> `lazygit`, `cc` -> `claude`, `cx` -> `codex`
- **WSL PATH fix**: Strips problematic `/mnt/c/` paths from Windows PATH interop, keeps only essential Windows system directories
- **tmux helpers**: `tks` (fzf multi-select session killer), `tss` (fzf session switcher)
- **Yazi wrapper** (`y`): Launches yazi and `cd`s into the last-visited directory on quit
- **Homebrew**: Linuxbrew shell environment initialization

---

## Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator (Windows side) | [Download](https://wezfurlong.org/wezterm/install/windows.html) |
| [JetBrains Mono](https://www.jetbrains.com/lp/mono/) + [Nerd Fonts](https://www.nerdfonts.com/) | Font with ligatures and icons | Install `JetBrainsMono Nerd Font` |
| tmux | Terminal multiplexer | `brew install tmux` |
| [Starship](https://starship.rs) | Shell prompt | `brew install starship` |
| [Yazi](https://yazi-rs.github.io) | Terminal file manager | `brew install yazi` |
| [eza](https://eza.rocks) | Modern `ls` replacement | `brew install eza` |
| [bat](https://github.com/sharkdp/bat) | Modern `cat` replacement | `brew install bat` |
| [fd](https://github.com/sharkdp/fd) | Modern `find` replacement | `brew install fd` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Modern `grep` replacement | `brew install ripgrep` |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder | `brew install fzf` |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` | `brew install zoxide` |
| [Atuin](https://atuin.sh) | Shell history | `brew install atuin` |
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal git UI | `brew install lazygit` |
| [Neovim](https://neovim.io) | Editor (used by yazi and as default editor) | `brew install neovim` |
| [ble.sh](https://github.com/akinomyoga/ble.sh) | Bash syntax highlighting | See ble.sh README |
| [glow](https://github.com/charmbracelet/glow) | Markdown renderer (yazi preview) | `brew install glow` |

Quick install for all Homebrew packages:

```bash
brew install yazi eza bat fd ripgrep fzf zoxide atuin starship tmux lazygit neovim glow
```

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/chesterchou1/wsl-dotfiles.git
cd wsl-dotfiles
```

### 2. Run the install script (WSL side)

This symlinks bash, tmux, starship, and yazi configs into place. Existing files are backed up with a `.bak` suffix.

```bash
./install.sh
```

### 3. Install WezTerm config (Windows side)

WezTerm runs on Windows, so its config file lives outside WSL. Copy or symlink it manually:

```powershell
# From PowerShell (Windows):
Copy-Item "\\wsl$\Ubuntu\tmp\wsl-dotfiles\wezterm\.wezterm.lua" "$HOME\.wezterm.lua"
```

Or create a symlink so edits stay in sync:

```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "\\wsl$\Ubuntu\path\to\wsl-dotfiles\wezterm\.wezterm.lua"
```

### 4. Install tmux plugins

Open tmux and press `Ctrl+a`, then `I` (capital i) to install TPM plugins:

- tmux-resurrect
- tmux-continuum
- vim-tmux-navigator

### 5. Install yazi plugins

```bash
ya pack -a yazi-rs/plugins:full-border
ya pack -a yazi-rs/plugins:smart-enter
ya pack -a yazi-rs/plugins:smart-filter
ya pack -a yazi-rs/plugins:git
```

### 6. Restart your shell

```bash
source ~/.bashrc
```

---

## WezTerm Key Bindings

Leader key is `Ctrl+b`. Press the leader, release, then press the action key within 1500ms.

### Pane Management

| Binding | Action |
|---------|--------|
| `Leader + -` | Split pane vertically |
| `Leader + \|` | Split pane horizontally |
| `Leader + h/j/k/l` | Navigate panes (left/down/up/right) |
| `Leader + Shift+H/J/K/L` | Resize panes by 5 cells |
| `Leader + z` | Toggle pane zoom |
| `Leader + x` | Close current pane |
| `Leader + Shift+{` | Rotate panes counter-clockwise |
| `Leader + Shift+}` | Rotate panes clockwise |

### Tab Management

| Binding | Action |
|---------|--------|
| `Leader + c` | New tab |
| `Leader + n` | Next tab |
| `Leader + p` | Previous tab |
| `Leader + 1-9` | Switch to tab by number |
| `Alt + 1-9` | Switch to tab by number (direct) |
| `Leader + ,` | Rename current tab |
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `Ctrl+Shift+t` | New tab |

### Workspaces and Launchers

| Binding | Action |
|---------|--------|
| `Leader + s` | Show workspaces |
| `Leader + Shift+W` | Create new workspace |
| `Leader + w` | Show tabs and domains |
| `Leader + m` | Show launch menu |
| `Leader + d` | Show domains |
| `Leader + f` | Toggle fullscreen |

### Copy Mode and Quick Select

| Binding | Action |
|---------|--------|
| `Leader + [` | Enter copy mode (vi keybindings) |
| `Leader + Space` | Quick select (git hashes, UUIDs, IPs, emails, paths) |
| `Leader + u` | Quick select and open URL |
| `Leader + g` | Quick select and copy git hash |
| `Ctrl+Shift+f` | Search |
| `Ctrl+Shift+c` | Copy to clipboard |
| `Ctrl+Shift+v` / `Ctrl+v` | Paste from clipboard |

### Copy Mode (Vi) Motions

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move left/down/up/right |
| `w/b/e` | Forward word / back word / end of word |
| `0` / `$` / `^` | Start of line / end of line / first non-blank |
| `g` / `G` | Top / bottom of scrollback |
| `H/M/L` | Top / middle / bottom of viewport |
| `v` / `V` / `Ctrl+v` | Character / line / block selection |
| `y` | Yank to clipboard and exit copy mode |
| `/` | Search, then `n/N` to cycle matches |
| `Ctrl+f/b` | Page down / up |
| `Ctrl+d/u` | Half page down / up |
| `q` / `Escape` | Exit copy mode |

### Other

| Binding | Action |
|---------|--------|
| `Leader + b` | Send literal `Ctrl+b` through to tmux/app |
| `Leader + r` | Reload WezTerm config |
| `Ctrl+Shift+p` | Command palette |
| `Ctrl+Shift+l` | Debug overlay |
| `Ctrl + +/-/0` | Increase / decrease / reset font size |
| `Shift+PageUp/Down` | Scroll page up/down |
| `Shift+Home/End` | Scroll to top/bottom |
| `Ctrl+Click` | Open hyperlink |
| `Right-click` | Paste from clipboard |
| `Triple-click` | Select entire line |

---

## tmux Key Bindings

Prefix is `Ctrl+a`.

| Binding | Action |
|---------|--------|
| `Prefix + -` | Split vertically |
| `Prefix + \|` | Split horizontally |
| `Prefix + h/j/k/l` | Navigate panes |
| `Prefix + H/J/K/L` | Resize panes (repeatable) |
| `Prefix + c` | New window |
| `Prefix + s` | Session tree viewer |
| `Prefix + S` | fzf session switcher (floating popup) |
| `Prefix + X` | fzf session killer (multi-select, floating popup) |
| `Prefix + p` | Floating popup shell |
| `Prefix + f` | Floating yazi file manager |
| `Prefix + w` | Window actions menu |
| `Prefix + g` | Workspace actions menu |
| `Prefix + </>` | Swap window left/right |
| `Prefix + r` | Reload tmux config |

---

## Directory Structure

```
wsl-dotfiles/
├── bash/
│   └── .bashrc                  # Shell config: aliases, tools, PATH, helpers
├── tmux/
│   ├── .tmux.conf               # tmux config: prefix, bindings, status bar, plugins
│   └── .tmux/
│       └── status-right.sh      # Status bar helper: git info + battery segment
├── starship/
│   └── starship.toml            # Prompt: format, git, languages, duration
├── yazi/
│   ├── yazi.toml                # File manager settings, openers, plugins
│   ├── keymap.toml              # Vim-style keybindings, navigation, file ops
│   ├── theme.toml               # Google Material dark theme, icons, filetype colors
│   └── init.lua                 # Plugin init: full-border, git status markers
├── wezterm/
│   └── .wezterm.lua             # Terminal emulator: theme, keys, tabs, workspaces
├── install.sh                   # Symlink installer for WSL-side configs
└── README.md
```

---

## Color Palette

A consistent Google Material Dark palette used across WezTerm, tmux, yazi, and starship:

```
Background    #000000  (WezTerm) / #1e1f22 (tmux/yazi base)
Surface       #141414  (WezTerm tabs) / #2a2b2f (tmux/yazi glass layer)
Highlight     #3c4043
Foreground    #e8eaed  (primary) / #9aa0a6 (muted) / #5f6368 (dim)

Blue          #8ab4f8  accent, active elements, directories
Green         #81c995  success, git added, battery ok
Yellow        #fdd663  warnings, git modified, prefix active
Red           #f28b82  errors, git deleted, battery low
Magenta       #c58af9  special, images, find position
Cyan          #78d9ec  info, untracked files
```
