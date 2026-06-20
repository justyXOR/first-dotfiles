-- Programs
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local browser = "firefox"

-- Autostart
hl.on("hyprland.start", function () 
    -- Important services
	hl.exec_cmd("waybar &")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1 &")
	hl.exec_cmd("hyprpaper &")
	hl.exec_cmd("dunst &")
	
	-- Screenshare
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
	
	-- Clipboard
	hl.exec_cmd("wl-paste --type text --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")
end)


-- Envinronment vars
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-- Windows design
hl.config({
    general = {
        gaps_in  = 15,
        gaps_out = 40,

        border_size = 1,

        col = {
            active_border   = "rgba(ffffff88)",
            inactive_border = "rgba(ffffff33)",
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,

        active_opacity   = 1.0,
        inactive_opacity = 0.9652512322267,

        shadow = {
            enabled      = false,
            range        = 8,
            render_power = 2,
            color        = 0x55000000,
            offset = {0,0},
           sharp = false,
        },

        blur = {
            enabled   = true,
            size      = 2,
            passes    = 2,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Windows rules

-- Float for Picture-in-Picture
hl.window_rule({
	name = "pip-float",
	match = { title = "Picture-in-Picture" },
	float = true
})

-- May be deleted in future
-- hl.window_rule({
--     name  = "move-hyprland-run",
--     match = { class = "hyprland-run" },
-- 
--     move  = "20 monitor_h-120",
--     float = true,
-- })

-- Fix drag issues with X apps
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


-- Dwindle, master, and scrolling
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
		new_status = "master",
	},
    scrolling = {
	    fullscreen_on_one_column = true,
    },
})

-- Misc configs
hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})


-- Input
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = -0.8,

        touchpad = {
            natural_scroll = false,
        },
    },
})


-- Binds
local mainMod = "SUPER"

-- Opens apps
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(terminal)) --terminal
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) --file manager
hl.bind(mainMod.."+Z",hl.dsp.exec_cmd("pavucontrol")) --volume control
hl.bind(mainMod.."+V",hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy")) --clipboard
hl.bind(mainMod.."+SHIFT+S",hl.dsp.exec_cmd("~/.local/bin/screenshot.sh")) --make screenshot

-- System
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")) --logout hypr
hl.bind(mainMod.."+SHIFT+O",hl.dsp.exec_cmd("shutdown now")) --shutdown
hl.bind(mainMod.."+SHIFT+R",hl.dsp.exec_cmd("killall waybar && waybar &")) --restart waybar

-- Window managment
hl.bind(mainMod .. " + D", hl.dsp.window.float({ action = "toggle" })) --toggle float
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) --toggle pseudo
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" })) --move focus left
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" })) --move focus right
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" })) --move focus up
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" })) --move focus down
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) --move windows
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) --resize windows
hl.bind(mainMod.."+Q",hl.dsp.window.kill()) --kill process
hl.bind(mainMod.."+W",hl.dsp.window.close()) --close window
hl.bind(mainMod.."+F",hl.dsp.window.fullscreen({mode=1})) --toggle fullscreen

-- Other features
hl.bind(mainMod.."+SPACE",hl.dsp.exec_cmd(menu)) --run menu
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) --toggle split

-- Workspaces
-- Switch workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Volume and brightness control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Audio control
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


-- Envinronment variables for NVIDIA
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("XDG_SESSION_TYPE", "wayland")
