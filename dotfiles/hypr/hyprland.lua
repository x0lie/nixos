-----------------
-- MY PROGRAMS --
-----------------

local terminal = "kitty"
local fileManager = "nemo"

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
})

hl.config({
    render = {
        direct_scanout = 2,
    },
})

hl.config({
    decoration = {
        rounding = 20,
        rounding_power = 2,
        active_opacity = 1,
        inactive_opacity = 0.95,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        -- blur = {
        --     enabled = true,
        --     size = 8,
        --     passes = 2,
        --     vibrancy = 0.1696,
        -- },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = 4,
    bezier  = "default"
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

----------------------------
-- WINDOWS AND WORKSPACES --
----------------------------

hl.window_rule({
    name  = "suppress-maximize-for-all",
    match = {
        class = ".*",
    },
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

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.window_rule({
  name = "steam-games",
  match = { class = "steam_app_.*" },
  content = "game",
})

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
require("dms.outputs")
require("dms.windowrules")
