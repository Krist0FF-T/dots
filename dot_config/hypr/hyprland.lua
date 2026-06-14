-- https://wiki.hypr.land/Configuring/

require("binds")

-- TODO:
-- - focus mode toggle
-- - some animations?
-- - groups?

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

-- # theming
-- env = XCURSOR_SIZE, 24
hl.env("XCURSOR_SIZE", "32")
-- env = XCURSOR_THEME, Adwaita
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- # functional
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- -- Nvidia stuff
hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("LIBVA_DRIVER_NAME", "iDH")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

-- # NOTE: Autostart

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper & qs & waybar & hyprsunset & fcitx5 & nm-applet & dunst")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- hl.exec_cmd("hyprlock")
end)

hl.config({ general = {
    -- TODO: 0 if FOCUS
    gaps_in = 10,
    gaps_out = 20,

    border_size = 2,
    -- TODO: colors
    -- col.active_border = $c_border_active
    -- col.inactive_border = $c_border_inactive

    resize_on_border = true,
    layout = "dwindle",
}})

hl.config({ dwindle = {
    preserve_split = true,
    force_split = 2,
}})

hl.config({ decoration = {
    -- TODO: 0 if FOCUS
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.95,
    blur = {
        enabled = true,
        size = 5,
        passes = 3,
        vibrancy = 0.5,
    },

    shadow = {
        enabled = true,
        -- enabled = false,
        range = 10,
    }
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
        -- kb_options = "caps:swapescape", -- hard to get used to
        repeat_delay = 250,

        touchpad = {
          natural_scroll = true,
          -- TODO: true if in focus mode
          disable_while_typing = false
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
    content = "none"
})

hl.workspace_rule({
    workspace = "special:magic",
    on_created_empty = "foot btop"
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
