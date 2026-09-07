--[[

 ,e e,  888 8e  Y8b Y888P 
d88 88b 888 88b  Y8b Y8P  
888   , 888 888   Y8b "   
 "YeeP" 888 888    Y8P

]]

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic") -- Changes the cursor
hl.env("XCURSOR_SIZE", "24") -- cursor

 
-- Toolkit Backend Variables
hl.env("XDG_CURRENT_DESKTOP", "Hyprland") -- idk
hl.env("XDG_SESSION_TYPE", "wayland") -- idk
hl.env("XDG_SESSION_DESKTOP", "Hyprland") -- idk
hl.env("XDG_UTILS_TERMINAL", "kitty") -- i dont know

-- QT Variables
hl.env("QT_QPA_PLATFORM", "wayland;xcb") -- idk
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1") -- disable the x and _ and square, but genuinely does it in like 2 apps ngl
hl.env("QT_QPA_PLATFOREMTHEME", "qt5ct") -- idk
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- idk too bruh

-- NVIDIA Specific
hl.env("GBM_BACKEND", "nvidia-drm") -- nvidia (huidia)
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
