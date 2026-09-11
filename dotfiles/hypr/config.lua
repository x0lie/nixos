hl.config({
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        focus_on_activate = true,
        disable_splash_rendering = true,
        background_color = 0xff1e1e2e, -- catppuccin mocha base
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

hl.env("QT_QPA_PLATFORMTHEME", "qtengine")
hl.env("QT_PLUGIN_PATH", "/etc/profiles/per-user/x0lie/lib/qt-6/plugins")
