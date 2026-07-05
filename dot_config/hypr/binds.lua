
-- NOTE: ideas:
-- - bind("le")(..) -> bind(.., { locked = true, release = true })
-- - change colors with keybinds? (that'd be really cool)

-- Don't recommend ALT (used by other programs)
local mod = "SUPER"

-- launch apps
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("foot"), { repeating = true })
hl.bind(mod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("foot qalc"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("foot yazi"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd("firefox -p"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("mpv $(wl-paste) --ytdl-format=\"bv[height<=1080]+ba\""))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("qs ipc call hee toggle"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("pkill wofi || wofi --show drun"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("pkill hyprpaper || hyprpaper"))

-- toggle internal monitor
hl.bind(mod .. " + CONTROL + M", function()
    local mon_name = "eDP-1"
    local enabled = (hl.get_monitor(mon_name) ~= nil)
    hl.monitor({
        output = mon_name,
        disabled = enabled
    })
end)

-- window management
hl.bind(mod .. " + SHIFT + C", hl.dsp.window.close(), { repeating = true })
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod .. " + CONTROL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))
hl.bind(mod .. " + Z", hl.dsp.layout("togglesplit"))

-- monitors
hl.bind(mod .. " + Tab", hl.dsp.focus({ monitor = "+1" })) -- TODO: test
hl.bind(mod .. " + SHIFT + Tab", hl.dsp.workspace.swap_monitors({ monitor1=0, monitor2=1 })) -- TODO: test

-- lock, exit
hl.bind(mod .. " + N", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.dpms(), { locked = true }) -- TODO: don't toggle dpms directly
hl.bind(mod .. " + CONTROL + N", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

hl.bind(mod .. " + CONTROL + Q", hl.dsp.exec_cmd("pkill Hyprland")) -- TODO: quit safely

-- screenshot
-- TODO:
-- - save to ~/Pictures/screenshots/
-- - copy to clipboard
-- - annotations (w snappy?)
hl.bind(       "Print",        hl.dsp.exec_cmd("grim -o HDMI-A-1     && notify-send 'screenshot taken' 'HDMI-A-1'"))
hl.bind(mod .. " + G",         hl.dsp.exec_cmd("grim                 && notify-send 'screenshot taken' 'all monitors'"))
hl.bind(mod .. " + SHIFT + G", hl.dsp.exec_cmd("grim -g \"$(slurp)\" && notify-send 'screenshot taken' 'selection'"))

-- switch workspaces
local workspace_keys = {"1", "2", "3", "4", "U", "I", "O", "P"}
for i, key in ipairs(workspace_keys) do
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

local direction_keys = { l = "H", r = "L", u = "K", d = "J" }
local dir_coords = { l = {-1; 0}, r = {1; 0}, u = {0; -1}, d = {0; 1} }

-- focus and move windows
for dir, key in pairs(direction_keys) do
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }))
    local c = dir_coords[dir]
    local d = 20
    local t = { x = c[1]*d, y = c[2]*d, relative = true }
    hl.bind(mod .. " + CONTROL + " .. key, hl.dsp.window.resize(t), { repeating = true })
end

-- alt-tab (old habits + allows focusing floating windows)
hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { repeating = true })

-- Example special workspace (scratchpad)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- # Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1", mouse = true}))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1", mouse = true}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multi-media -----------------------------------------------------------------

-- TODO: shorthands for readability
-- $bright = exec, brightnessctl s # +/-
-- $volume = exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ # +/-
-- $toggle_mute = exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

hl.bind("XF86PowerOff", hl.dsp.exec_cmd("notify-send 'nice try, haha'"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- F keys for keyboards without multi-media keys
hl.bind(mod .. " + F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind(mod .. " + F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind(mod .. " + F3", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind(mod .. " + SHIFT + F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%-"), { locked = true, repeating = true })
hl.bind(mod .. " + SHIFT + F3", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%+"), { locked = true, repeating = true })
hl.bind(mod .. " + F6", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })
hl.bind(mod .. " + F7", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind(mod .. " + SHIFT + F6", hl.dsp.exec_cmd("brightnessctl s 1%"), { locked = true, repeating = true })
hl.bind(mod .. " + SHIFT + F7", hl.dsp.exec_cmd("brightnessctl s 100%"), { locked = true, repeating = true })

local function temp(sign)
    return hl.dsp.exec_cmd("hyprctl hyprsunset temperature " .. sign .. "100")
end

hl.bind(mod .. " + CONTROL + F6", temp("-"), { repeating = true })
hl.bind(mod .. " + CONTROL + F7", temp("+"), { repeating = true })
hl.bind(mod .. " + KP_HOME", temp("-"), { repeating = true })
hl.bind(mod .. " + KP_UP", temp("+"), { repeating = true })

-- NOTE: might not be possible in lua?
-- # zoom in on the cursor
-- bind = $mod ALT, K, exec, hyprctl keyword cursor:zoom_factor 5
-- bind = $mod ALT, J, exec, hyprctl keyword cursor:zoom_factor 1
