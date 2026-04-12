-- Yazi init.lua — plugin setup.

-- Theme overrides for the git plugin (use palette tokens).
th.git = th.git or {}
th.git.modified  = ui.Style():fg("#fdd663")
th.git.added     = ui.Style():fg("#81c995")
th.git.untracked = ui.Style():fg("#78d9ec")
th.git.ignored   = ui.Style():fg("#5f6368")
th.git.deleted   = ui.Style():fg("#f28b82"):bold()
th.git.updated   = ui.Style():fg("#8ab4f8")

-- Draw a full frame around the manager panes.
require("full-border"):setup()

-- Show git status markers next to files.
require("git"):setup()
