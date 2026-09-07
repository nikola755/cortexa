--[[

                ,e,                       d8   ,e,                         
 ,"Y88b 888 8e   "  888 888 8e   ,"Y88b  d88    "   e88 88e  888 8e   dP"Y 
"8" 888 888 88b 888 888 888 88b "8" 888 d88888 888 d888 888b 888 88b C88b  
,ee 888 888 888 888 888 888 888 ,ee 888  888   888 Y888 888P 888 888  Y88D 
"88 888 888 888 888 888 888 888 "88 888  888   888  "88 88"  888 888 d,dP  

]]

animations = {
    enabled = true,
},

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("slide",          { type = "bezier", points = { {0.2, 0.8},  {0.2, 1} } })
hl.curve("scale",          { type = "bezier", points = { {0.16, 1},   {0.3, 1} } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 6.0,  bezier = "scale" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 6.5,  bezier = "scale",        style = "popin 75%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2.49, bezier = "almostLinear"})
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 5.5,  bezier = "slide",        style = "slidefade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 5.6,  bezier = "slide",        style = "slidefade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 5.6,  bezier = "slide",        style = "slidefade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })