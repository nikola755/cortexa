--[[

     888               ,e,                  
 e88 888  ,e e,   dP"Y  "   e88 888 888 8e  
d888 888 d88 88b C88b  888 d888 888 888 88b 
Y888 888 888   ,  Y88D 888 Y888 888 888 888 
 "88 888  "YeeP" d,dP  888  "88 888 888 888 
                             ,  88P         
                            "8",P"   

]]

hl.config({
    general = {
        gaps_in  = 7,
        gaps_out = 20,

        border_size = 0,

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 14,
        rounding_power = 7,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 8,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 6,
            passes    = 4,
            vibrancy  = 0.1696,
        },
    }
})

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})