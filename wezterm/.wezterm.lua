local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- ============================================================================
-- Theme - Google Dark (Material Design-inspired)
-- ============================================================================
config.colors = {
  foreground = '#a0a0a0',
  background = '#000000',
  cursor_bg = '#e0e0e0',
  cursor_fg = '#000000',
  cursor_border = '#e0e0e0',
  selection_bg = '#1a1a2e',
  selection_fg = 'none',
  ansi = {
    '#000000', -- black
    '#e06070', -- red
    '#50c878', -- green
    '#e0c060', -- yellow
    '#5a9bcf', -- blue
    '#b07ec0', -- magenta
    '#50b0b0', -- cyan
    '#a0a0a0', -- white
  },
  brights = {
    '#404040', -- bright black
    '#f08090', -- bright red
    '#70e898', -- bright green
    '#f0d888', -- bright yellow
    '#7ab8e8', -- bright blue
    '#c898d8', -- bright magenta
    '#70d0d0', -- bright cyan
    '#d0d0d0', -- bright white
  },
  tab_bar = {
    background = '#000000',
    active_tab = { bg_color = '#141414', fg_color = '#e0e0e0', intensity = 'Bold' },
    inactive_tab = { bg_color = '#000000', fg_color = '#505050' },
    inactive_tab_hover = { bg_color = '#141414', fg_color = '#a0a0a0' },
    new_tab = { bg_color = '#000000', fg_color = '#505050' },
    new_tab_hover = { bg_color = '#141414', fg_color = '#a0a0a0' },
  },
  compose_cursor = '#e0e0e0',
  split = '#141414',
}

-- ============================================================================
-- Font - Modern Setup with Fallbacks
-- ============================================================================
config.font = wezterm.font_with_fallback {
  { family = 'JetBrains Mono', weight = 'Medium' },
  'Noto Color Emoji',
}
config.font_size = 13
config.line_height = 1.2
config.cell_width = 1.0
config.freetype_load_flags = 'NO_HINTING'
config.freetype_load_target = 'Light'

-- ============================================================================
-- GPU & Performance (OpenGL is more stable with nvim on Windows)
-- ============================================================================
config.front_end = 'OpenGL'
config.max_fps = 60
config.animation_fps = 30

-- ============================================================================
-- Window & Appearance
-- ============================================================================
config.window_background_opacity = 1.0
-- Disabled Acrylic - causes freezing with nvim
-- config.win32_system_backdrop = 'Acrylic'
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.integrated_title_button_style = 'Windows'
config.integrated_title_button_alignment = 'Right'
config.window_padding = { left = 12, right = 12, top = 12, bottom = 8 }
config.initial_cols = 130
config.initial_rows = 35
config.inactive_pane_hsb = { saturation = 0.85, brightness = 0.7 }
config.window_close_confirmation = 'NeverPrompt'

-- ============================================================================
-- Cursor & Terminal
-- ============================================================================
config.term = 'xterm-256color'
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.force_reverse_video_cursor = false

-- Critical for nvim responsiveness
config.enable_kitty_keyboard = true
config.use_dead_keys = false

-- ============================================================================
-- Tab Bar - Modern Fancy Style
-- ============================================================================
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 28
config.show_tab_index_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true

config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono', weight = 'Bold' },
  font_size = 9,
  active_titlebar_bg = '#000000',
  inactive_titlebar_bg = '#000000',
}

-- ============================================================================
-- Behavior
-- ============================================================================
config.default_domain = 'WSL:Ubuntu'
config.scrollback_lines = 10000
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}
config.enable_scroll_bar = true
config.min_scroll_bar_height = '2cell'
config.check_for_updates = false
config.show_update_window = false

-- Notifications
config.notification_handling = 'AlwaysShow'

-- ============================================================================
-- Background Image (Uncomment and set path to enable)
-- ============================================================================
-- config.window_background_image = 'C:/Users/chesterchou/Pictures/wallpaper.png'
-- config.window_background_image_hsb = {
--   brightness = 0.02,
--   hue = 1.0,
--   saturation = 0.5,
-- }

-- ============================================================================
-- Launch Menu - Quick Shell Access (Leader+w or right-click new tab)
-- ============================================================================
config.launch_menu = {
  { label = wezterm.nerdfonts.md_powershell .. '  PowerShell', args = { 'pwsh', '-NoLogo' } },
  { label = wezterm.nerdfonts.md_console .. '  CMD', args = { 'cmd' } },
  { label = wezterm.nerdfonts.cod_terminal_bash .. '  Git Bash', args = { 'C:/Program Files/Git/bin/bash.exe', '-l' } },
  { label = wezterm.nerdfonts.md_ubuntu .. '  WSL Ubuntu', args = { 'wsl', '-d', 'Ubuntu' } },
  { label = wezterm.nerdfonts.md_nodejs .. '  Node REPL', args = { 'node' } },
  { label = wezterm.nerdfonts.dev_python .. '  Python', args = { 'python' } },
  { label = wezterm.nerdfonts.md_robot .. '  Claude Code', args = { 'pwsh', '-NoLogo', '-Command', 'claude' } },
}

-- ============================================================================
-- WSL Domains
-- ============================================================================
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu',
    distribution = 'Ubuntu',
    default_cwd = '~',
  },
}

-- ============================================================================
-- SSH Domains (Edit these with your servers)
-- ============================================================================
config.ssh_domains = {
  -- Example: Uncomment and edit to add your servers
  -- {
  --   name = 'dev-server',
  --   remote_address = 'dev.example.com',
  --   username = 'chester',
  --   multiplexing = 'WezTerm',  -- Enables persistent connections
  -- },
  -- {
  --   name = 'prod-server',
  --   remote_address = 'prod.example.com:22',
  --   username = 'chester',
  --   multiplexing = 'WezTerm',
  -- },
}

-- ============================================================================
-- Unix Domains (Local Multiplexing)
-- ============================================================================
-- Disabled: probing unix domains adds startup latency
-- config.unix_domains = { { name = 'unix' } }

-- ============================================================================
-- Hyperlinks - Enhanced Pattern Matching
-- ============================================================================
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, { regex = [[\b[A-Za-z0-9-]+/[A-Za-z0-9_.-]+#\d+\b]], format = 'https://github.com/$0' })
table.insert(config.hyperlink_rules, { regex = [[\bgh:([A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+)\b]], format = 'https://github.com/$1' })
table.insert(config.hyperlink_rules, { regex = [[file://\S+]], format = '$0' })

-- ============================================================================
-- Quick Select - Modern Patterns
-- ============================================================================
config.quick_select_alphabet = 'asdfqwerzxcvjklmiuopghtybn'
config.quick_select_patterns = {
  '[0-9a-f]{7,40}',                           -- Git hashes
  '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}', -- UUIDs
  '(?:[0-9]{1,3}\\.){3}[0-9]{1,3}',           -- IPv4
  '[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}', -- Emails
  '\\$?[A-Z_][A-Z0-9_]*',                     -- ENV vars
  '/[\\w.-]+(?:/[\\w.-]+)+',                  -- Unix paths
  '[A-Z]:\\\\[\\w\\\\.-]+',                   -- Windows paths
}

-- ============================================================================
-- Smart Key Passthrough for nvim (with caching to prevent freezes)
-- ============================================================================
local vim_cache = {}
local cache_timeout = 2000 -- ms (longer cache avoids repeated process lookups)

local function is_vim(pane)
  local pane_id = pane:pane_id()
  local now = wezterm.time.now() * 1000
  local cached = vim_cache[pane_id]

  if cached and (now - cached.time) < cache_timeout then
    return cached.is_vim
  end

  local success, process_name = pcall(function()
    return pane:get_foreground_process_name()
  end)

  local result = false
  if success and process_name then
    local name = process_name:lower()
    result = name:match('n?vim') ~= nil
  end

  vim_cache[pane_id] = { is_vim = result, time = now }
  return result
end

local function conditional_activate_pane(window, pane, direction, vim_key)
  if is_vim(pane) then
    window:perform_action(act.SendKey { key = vim_key, mods = 'CTRL' }, pane)
  else
    window:perform_action(act.ActivatePaneDirection(direction), pane)
  end
end

wezterm.on('activate-pane-left', function(window, pane) conditional_activate_pane(window, pane, 'Left', 'h') end)
wezterm.on('activate-pane-down', function(window, pane) conditional_activate_pane(window, pane, 'Down', 'j') end)
wezterm.on('activate-pane-up', function(window, pane) conditional_activate_pane(window, pane, 'Up', 'k') end)
wezterm.on('activate-pane-right', function(window, pane) conditional_activate_pane(window, pane, 'Right', 'l') end)

-- ============================================================================
-- Leader Key (Ctrl+b — distinct from tmux's Ctrl+a)
-- ============================================================================
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1500 }

-- ============================================================================
-- Keybindings
-- ============================================================================
config.keys = {
  -- Pane navigation via leader (no Ctrl hijacking — let tmux/vim handle Ctrl+h/j/k/l)
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- Command Palette
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },

  -- Leader key commands (Ctrl+a, then key)
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } },
  { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'b', mods = 'LEADER', action = act.SendKey { key = 'b', mods = 'CTRL' } },
  { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },
  { key = 'w', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'TABS|DOMAINS' } },
  { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = 'm', mods = 'LEADER', action = act.ShowLauncher },                              -- launch menu
  { key = 'd', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'DOMAINS' } },    -- domains only
  -- { key = 'Enter', mods = 'LEADER', action = act.AttachDomain 'unix' },                 -- disabled: unix domain removed

  -- Leader + number for tabs
  { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(-1) },

  -- Direct tab switching
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(-1) },

  -- QuickSelect mode
  { key = 'Space', mods = 'LEADER', action = act.QuickSelect },
  { key = 'u', mods = 'LEADER', action = act.QuickSelectArgs {
    label = 'open url',
    patterns = { 'https?://\\S+' },
    action = wezterm.action_callback(function(window, pane)
      local url = window:get_selection_text_for_pane(pane)
      wezterm.open_with(url)
    end),
  }},
  { key = 'g', mods = 'LEADER', action = act.QuickSelectArgs {
    label = 'git hash',
    patterns = { '[0-9a-f]{7,40}' },
    action = wezterm.action_callback(function(window, pane)
      local hash = window:get_selection_text_for_pane(pane)
      window:copy_to_clipboard(hash)
    end),
  }},

  -- Tabs - quick actions
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- Pane resize with leader
  { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },

  -- Pane swap
  { key = '{', mods = 'LEADER|SHIFT', action = act.RotatePanes 'CounterClockwise' },
  { key = '}', mods = 'LEADER|SHIFT', action = act.RotatePanes 'Clockwise' },

  -- Tab rename
  { key = ',', mods = 'LEADER', action = act.PromptInputLine {
    description = 'Tab name:',
    action = wezterm.action_callback(function(window, pane, line)
      if line then window:active_tab():set_title(line) end
    end),
  }},

  -- Workspace
  { key = 'W', mods = 'LEADER|SHIFT', action = act.PromptInputLine {
    description = 'New workspace name:',
    action = wezterm.action_callback(function(window, pane, line)
      if line then window:perform_action(act.SwitchToWorkspace { name = line }, pane) end
    end),
  }},

  -- Font size
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },

  -- Search & Copy
  { key = 'f', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

  -- Scroll
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  { key = 'Home', mods = 'SHIFT', action = act.ScrollToTop },
  { key = 'End', mods = 'SHIFT', action = act.ScrollToBottom },

  -- Reload config
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },
}

-- ============================================================================
-- Copy Mode - Vi keybindings (Enhanced)
-- ============================================================================
config.key_tables = {
  copy_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
    { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
    { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
    { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
    { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
    { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' } },
    { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
    { key = 'y', mods = 'NONE', action = act.Multiple {
      { CopyTo = 'ClipboardAndPrimarySelection' },
      { CopyMode = 'Close' },
    }},
    { key = '/', mods = 'NONE', action = act.CopyMode 'EditPattern' },
    { key = 'n', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    { key = 'N', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
    { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
    { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
    { key = 'd', mods = 'CTRL', action = act.CopyMode { MoveByPage = 0.5 } },
    { key = 'u', mods = 'CTRL', action = act.CopyMode { MoveByPage = -0.5 } },
  },
  search_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
  },
}

-- ============================================================================
-- Mouse
-- ============================================================================
config.mouse_bindings = {
  { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CTRL', action = act.OpenLinkAtMouseCursor, mouse_reporting = true },
  { event = { Down = { streak = 3, button = 'Left' } }, mods = 'NONE', action = act.SelectTextAtMouseCursor 'Line' },
  { event = { Down = { streak = 1, button = 'Right' } }, mods = 'NONE', action = act.PasteFrom 'Clipboard' },
}

-- ============================================================================
-- Process Icons (Extended)
-- ============================================================================
local process_icons = {
  ['pwsh'] = wezterm.nerdfonts.md_powershell,
  ['powershell'] = wezterm.nerdfonts.md_powershell,
  ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
  ['fish'] = wezterm.nerdfonts.md_fish,
  ['cmd'] = wezterm.nerdfonts.md_console,
  ['wsl'] = wezterm.nerdfonts.md_linux,
  ['ubuntu'] = wezterm.nerdfonts.md_ubuntu,
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['nvim'] = wezterm.nerdfonts.custom_neovim,
  ['python'] = wezterm.nerdfonts.dev_python,
  ['python3'] = wezterm.nerdfonts.dev_python,
  ['node'] = wezterm.nerdfonts.md_nodejs,
  ['npm'] = wezterm.nerdfonts.dev_npm,
  ['bun'] = wezterm.nerdfonts.md_food_croissant,
  ['deno'] = wezterm.nerdfonts.seti_typescript,
  ['git'] = wezterm.nerdfonts.dev_git,
  ['lazygit'] = wezterm.nerdfonts.dev_git,
  ['htop'] = wezterm.nerdfonts.md_chart_bar,
  ['btop'] = wezterm.nerdfonts.md_chart_bar,
  ['top'] = wezterm.nerdfonts.md_chart_bar,
  ['ssh'] = wezterm.nerdfonts.md_ssh,
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['cargo'] = wezterm.nerdfonts.dev_rust,
  ['rustc'] = wezterm.nerdfonts.dev_rust,
  ['go'] = wezterm.nerdfonts.md_language_go,
  ['lua'] = wezterm.nerdfonts.seti_lua,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['kubectl'] = wezterm.nerdfonts.md_kubernetes,
  ['k9s'] = wezterm.nerdfonts.md_kubernetes,
  ['psql'] = wezterm.nerdfonts.dev_postgresql,
  ['mysql'] = wezterm.nerdfonts.dev_mysql,
  ['redis-cli'] = wezterm.nerdfonts.dev_redis,
  ['gh'] = wezterm.nerdfonts.dev_github_badge,
  ['claude'] = wezterm.nerdfonts.md_robot,
}

local function get_process_icon(process_name)
  local name = process_name:lower():gsub('%.exe$', '')
  return process_icons[name] or wezterm.nerdfonts.cod_terminal
end

-- ============================================================================
-- Tab Title Formatter
-- ============================================================================
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local process_name = pane.foreground_process_name:match("([^/\\]+)$") or ""
  local icon = get_process_icon(process_name)

  local title = tab.tab_title
  if not title or #title == 0 then
    title = pane.title
    if not title or #title == 0 then
      title = process_name:gsub('%.exe$', '')
    end
  end

  if #title > max_width - 6 then
    title = title:sub(1, max_width - 8) .. '..'
  end

  local idx = tab.tab_index + 1
  local zoomed = ''
  for _, p in ipairs(tab.panes) do
    if p.is_zoomed then zoomed = wezterm.nerdfonts.cod_screen_full .. ' ' break end
  end

  return {
    { Text = string.format(' %d: %s%s %s ', idx, zoomed, icon, title) },
  }
end)

-- ============================================================================
-- Right Status Bar (Simplified for performance)
-- ============================================================================
-- Sysinfo removed — PowerShell CIM queries blocked the UI and caused lag/CMD flashes.
-- CPU/memory stats are shown via tmux-cpu plugin in the tmux status bar instead.

wezterm.on('update-right-status', function(window, pane)
  local mode = window:active_key_table() or ''
  local leader = window:leader_is_active()
  local workspace = window:active_workspace()

  local dim = '#505050'
  local bright = '#d0d0d0'
  local elements = {}

  if leader then
    table.insert(elements, { Foreground = { Color = bright } })
    table.insert(elements, { Text = ' LEADER ' })
  end

  if mode ~= '' then
    table.insert(elements, { Foreground = { Color = dim } })
    table.insert(elements, { Text = mode:upper() .. ' ' })
  end

  if workspace and workspace ~= 'default' then
    table.insert(elements, { Foreground = { Color = dim } })
    table.insert(elements, { Text = workspace .. '  ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

-- ============================================================================
-- Workspaces - Default Setup
-- ============================================================================
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {
    workspace = 'default',
    domain = { DomainName = 'WSL:Ubuntu' },
  })
  window:gui_window():maximize()
end)

return config
