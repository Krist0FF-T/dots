-- https://wiki.hypr.land/Configuring/

require("binds")

-- TODO:
-- - focus mode toggle keybind
-- - groups?
-- - single-monitor - only external if connected

local FOCUS = true

-- special workspaces

local function mkSpecial(name, bind, command, window_size)
    local mod = "SUPER"
    hl.bind(mod .. " + " .. bind, hl.dsp.workspace.toggle_special(name))
    hl.bind(mod .. " + SHIFT + " .. bind, hl.dsp.window.move({ workspace = "special:"..name }))

    hl.workspace_rule({
        workspace = "special:" .. name,
        on_created_empty = command
    })
    hl.window_rule({
        match = {workspace = "special:" .. name},
        float = true,
        size = window_size or {1280, 720},
    })
end

mkSpecial("calendar", "period", "foot ikhal")
mkSpecial("log", "comma", "foot -D ~/Documents/exobrain nvim log/year_2026_27.md")
mkSpecial("calculator", "minus", "foot qalc")
mkSpecial("btop", "s", "foot btop")
mkSpecial("scratch", "d", "foot nvim", {480, 240})

-- Monitors --------------------------------------------------------------------

-- auto-configure
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-- external
local mon_external = "HDMI-A-1"
hl.monitor({
    output   = mon_external,
    mode     = "1920x1080@75",
    position = "0x0",
    scale    = 1,
})

-- internal
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto-center-left",
    scale    = 1,
})

-- Environment variables -------------------------------------------------------
-- TODO: move out most of this

-- # theming
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GTK_IM_MODULE", "")

-- # functional
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- -- -- Nvidia stuff
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("NVD_BACKEND", "direct")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper") -- wallpaper daemon
    hl.exec_cmd("qs") -- quickshell - custom widgets
    -- hl.exec_cmd("waybar") -- TODO: custom quickshell bar
    -- TODO: switch to gammastep for automatic temperature based on sun position
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("fcitx5") -- for different writing systems (jp, zh, ru)
    -- hl.exec_cmd("nm-applet")
    hl.exec_cmd("dunst") -- notification daemon - TODO: custom in quickshell (low priority)
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("systemctl --user start hyprpolkitagent") -- elevated prileges
    hl.exec_cmd("aw-server")
    hl.exec_cmd("awatcher")
end)

hl.config({ general = {
    gaps_in = FOCUS and 0 or 10,
    gaps_out = FOCUS and 0 or 20,

    border_size = 2,
    col = {
        active_border = "#ffffff60",
        inactive_border = "#00000000",
    },

    layout = "dwindle",
}})

hl.config({ dwindle = {
    preserve_split = true,
    force_split = 2,
}})

hl.config({ decoration = {
    rounding = FOCUS and 0 or 10,

    dim_inactive = true,
    dim_strength = 0.1,

    -- active_opacity = 1.0,
    -- inactive_opacity = 0.8,
    blur = {
        enabled = not FOCUS,
        size = 8,
        passes = 3,
        vibrancy = 0.5,
    },

    shadow = {
        enabled = true,
        -- enabled = false,
        range = 10,
        color = "#000000"
    },
}})

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = 1,
    -- background_color = "#ff0000"
    -- mouse_move_enables_dmps = true, -- FIX
    key_press_enables_dpms = true,
  }
})

hl.config({
  animations = {
    -- no animations.
    enabled = false
  }
})


-- Input -----------------------------------------------------------------------

hl.config({
    input = {
        kb_layout = "hu",
        repeat_rate = 32,
        kb_options = "caps:escape",
        repeat_delay = 250,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = false -- FOCUS
        },
    }
})

-- Rules -----------------------------------------------------------------------

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    match = { class = ".*mpv.*" },
    content = "none",
    border_color = "#00f090",
})

-- # windowrulev2 = bordercolor rgb(ff0000), xwayland:1

hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })

-- "Smart gaps" / "No gaps when only"
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    match = { float = false, workspace = "w[tv1]s[false]" },
    border_size = 0, rounding = 0, no_shadow = true
})
hl.window_rule({
    match = { float = false, workspace = "f[1]s[false]" },
    border_size = 0, rounding = 0, no_shadow = true
})
