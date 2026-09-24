---------------
-- AUTOSTART --
---------------

hl.on("hyprland.start", function()
  hl.exec_cmd(
    [[xrandr --output "$(hyprctl monitors -j | jq -r '.[] | select(.description=="Samsung Electric Company LC27G7xT H4ZT400384") | .name')" --primary]]
  )
end)

hl.on("hyprland.start", function()
  hl.exec_cmd("dms run --session")
end)

-----------------
-- ENVIRONMENT --
-----------------

hl.env("QT_QPA_PLATFORMTHEME", "qtengine")
hl.env("QT_PLUGIN_PATH", "/etc/profiles/per-user/x0lie/lib/qt-6/plugins")

-------------------
-- LOOK AND FEEL --
-------------------

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 3,
    resize_on_border = false,
    -- allow_tearing = true,
    layout = "dwindle",
    col = {
      active_border = "rgba(CBA6F7aa)",
      inactive_border = "rgba(313244ff)",
    },
  },
  render = {
    direct_scanout = 2,
  },
  xwayland = {
    force_zero_scaling = true,
  },
})

hl.config({
  decoration = {
    rounding = 20,
    rounding_power = 2,
    active_opacity = 1,
    inactive_opacity = 0.95,
  },
})

hl.animation({
  leaf    = "windows",
  enabled = true,
  speed   = 4,
  bezier  = "default",
})

hl.animation({
  leaf    = "workspaces",
  enabled = true,
  speed = 4,
  spring = "default",
  style = "fade"
})

------------------
-- WINDOW RULES --
------------------

hl.window_rule({
  name  = "suppress-maximize-for-all",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name  = "fix-xwayland-dragging",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    fullscreen = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "steam-games-content",
  match = { class = "steam_app_.*" },
  content = "game",
})

hl.window_rule({
  name = "gamescope-content",
  match = { class = "gamescope" },
  content = "game",
})

hl.window_rule({
  match = { content = "game" },
  opacity = 1,
})

hl.window_rule({
  name = "bitwarden-float",
  match = { class = "brave-nngceckbapebfimnlniiiahkandclblb-Default" },
  float = true
})

--------------------
-- GAME WORKSPACE --
--------------------

-- Numeric id so the workspace keeps its identity when renamed.
local GAME_WS = 10
local GAME_WS_IDLE_NAME = "game"

hl.workspace_rule({
  workspace    = tostring(GAME_WS),
  default_name = GAME_WS_IDLE_NAME,
  monitor      = "desc:Samsung Electric Company LC27G7xT H4ZT400384",
  gaps_in = 0, gaps_out = 0, no_border = true, no_rounding = true,
})

hl.window_rule({
  name      = "games-workspace",
  match     = { content = "game" },
  workspace = GAME_WS,
})

local function rename(name)
  hl.dispatch(hl.dsp.workspace.rename({ workspace = GAME_WS, name = name }))
end

-- window.title also fires pre-map, where the workspace is still nil.
local function on_game_ws(w)
  local ws = w and w.workspace
  return ws ~= nil and ws.id == GAME_WS
end

-- Show the running game's title as the workspace name.
for _, event in ipairs({ "window.open", "window.title" }) do
  hl.on(event, function(w)
    if on_game_ws(w) and w.title ~= "" then rename(w.title) end
  end)
end

-- On quit, drop back to the monitor's last workspace and let this one vanish.
hl.on("window.close", function(w)
  if not on_game_ws(w) then return end
  local ws = w.workspace
  if ws.windows > 1 then return end
  rename(GAME_WS_IDLE_NAME)
  -- Only when focused here, so a background quit cannot steal focus.
  local focused = hl.get_active_workspace()
  if not focused or focused.id ~= GAME_WS then return end
  local last = hl.get_last_workspace(ws.monitor)
  if last then hl.dispatch(hl.dsp.focus({ workspace = last.id })) end
end)

-------------
-- MODULES --
-------------

require("monitors")
require("devices")
require("config")
require("binds")

-- DMS Include Configs
-- require("dms.binds")
-- require("dms.binds-user")
require("dms.colors")
-- require("dms.cursor")
require("dms.layout")
-- require("dms.outputs")
require("dms.windowrules")
