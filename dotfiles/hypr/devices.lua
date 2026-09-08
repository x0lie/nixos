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

hl.device({
    name = "finalmouse-ultralightx-mouse",
    sensitivity = -0.1,
})

hl.device({
    name = "finalmouse-ultralightx-dongle-mouse",
    sensitivity = -0.1,
})
