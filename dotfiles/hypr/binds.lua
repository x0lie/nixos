-- Window control --

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

-- Shortcuts --

hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + U", hl.dsp.exec_cmd("nemo"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("Print", hl.dsp.exec_cmd("grimblast --notify copy area"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"))

-- Workspaces --

for i = 1, 9 do
  hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

for i = 1, 9 do
  hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Magic Workspaces --

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Multimedia --

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
