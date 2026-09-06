--------------
-- MONITORS --
--------------

--Samsung
hl.monitor({
    output   = "desc:Samsung Electric Company LC27G7xT H4ZT400384",
    mode     = "2560x1440@239.96",
    position = "0x0",
    scale    = 1,
    vrr = 1,
})

--Acer
hl.monitor({
    output   = "desc:Acer Technologies Acer XB241H #ASMZPaMPfFDd",
    mode     = "1920x1080@143.98",
    position = "-1080x-300",
    scale    = 1,
    transform = 1,
    vrr = 1,
})

--LG
hl.monitor({
    output   = "desc:LG Electronics LG TV 0x01010101",
    mode     = "1920x1080@60",
    position = "-3000x-600",
    scale    = 1,
})

-----------------
-- MY PROGRAMS --
-----------------

local terminal = "kitty"
local fileManager = "nemo"
local menu = "wofi --show drun"

---------------
-- AUTOSTART --
---------------

hl.on("hyprland.start", function()
    hl.exec_cmd("vesktop & brave")
end)

---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------

-- Moved to ~/.config/uwsm/{env,env-hyprland}

-- HYPRCURSOR_THEME/SIZE now set declaratively via home.pointerCursor in home.nix

-----------------
-- PERMISSIONS --
-----------------

-------------------
-- LOOK AND FEEL --
-------------------

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 3,
        resize_on_border = false,
        -- allow_tearing = true,
        layout = "dwindle",
        col = {
            active_border = "rgba(0aa5adaa)",
            inactive_border = "rgba(59595980)",
        },
    },
})

hl.config({
    render = {
        direct_scanout = 1,
    },
})

hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1,
        inactive_opacity = 1,
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

hl.config({
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        focus_on_activate = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

-----------
-- INPUT --
-----------

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- hl.config({
--     debug = {
--         overlay = true,
--     },
-- })

hl.device({
    name = "finalmouse-ultralightx-mouse",
    sensitivity = -0.1,
})

hl.device({
    name = "finalmouse-ultralightx-dongle-mouse",
    sensitivity = -0.1,
})

-----------------
-- KEYBINDINGS --
-----------------

--Window control

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + BackSpace", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen_state({
    internal = 2,
    client   = 0,
    action   = "toggle"
}))
hl.bind("SUPER + H", hl.dsp.window.float())
hl.bind("SUPER + P", hl.dsp.window.pseudo())

hl.bind("SUPER + J", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + I", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "down" }))

--Shortcuts

hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + U", hl.dsp.exec_cmd("nemo"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind("Print", hl.dsp.exec_cmd("grimblast --notify copy area"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"))

--Workspaces

for i = 1, 9 do
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.focus({ workspace = i }))
end

for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
end

--Stuff I don't understand

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("SUPER + equal", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j| jq '.float* 1.1')"))
hl.bind("SUPER + minus", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j| jq '(.float* 0.9)| if.< 1 then 1 else.end')"))
hl.bind("SUPER + KP_ADD", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j| jq '.float* 1.1')"))
hl.bind("SUPER + KP_SUBTRACT", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j| jq '(.float* 0.9)| if.< 1 then 1 else.end')"))
hl.bind("SUPER + SHIFT" .. " + " .. "mouse_down", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind("SUPER + SHIFT" .. " + " .. "mouse_up", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind("SUPER + SHIFT" .. " + " .. "minus", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind("SUPER + SHIFT" .. " + " .. "KP_SUBTRACT", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind("SUPER + SHIFT" .. " + " .. 0, hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))

--Multimedia

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })

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

-- DMS Include Configs
require("dms.cursor")
require("dms.binds")
require("dms.binds-user")
