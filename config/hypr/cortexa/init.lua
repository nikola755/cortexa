--[[

                            d8                            
 e88'888  e88 88e  888,8,  d88    ,e e,   Y8b Y8Y  ,"Y88b 
d888  '8 d888 888b 888 "  d88888 d88 88b   Y8b Y  "8" 888 
Y888   , Y888 888P 888     888   888   ,  e Y8b   ,ee 888 
 "88,e8'  "88 88"  888     888    "YeeP" d8b Y8b  "88 888 

]]

local cortexa = {}

cortexa.terminal   = "kitty"
cortexa.files      = "thunar"
cortexa.browser    = "zen-browser"
cortexa.screenshot = "noctalia msg screenshot-region"
cortexa.wallpaper  = "noctalia msg panel-toggle wallpaper"
cortexa.launcher   = "noctalia msg panel-toggle launcher"
cortexa.code       = "kitty -e nvim"
cortexa.center     = "noctalia msg panel-toggle control-center"
cortexa.settings   = "noctalia msg settings-toggle"
cortexa.switcher   = "noctalia msg window-switcher"
cortexa.lock       = "noctalia msg session lock"
cortexa.session    = "noctalia msg panel-toggle session"
cortexa.clipboard  = "noctalia msg panel-toggle clipboard"
cortexa.notes      = "logseq"
cortexa.ai         = "kitty -e opencode"

return cortexa
