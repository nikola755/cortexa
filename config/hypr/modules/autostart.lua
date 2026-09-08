--[[

                    d8                     d8                    d8   
 ,"Y88b 8888 8888  d88    e88 88e   dP"Y  d88    ,"Y88b 888,8,  d88   
"8" 888 8888 8888 d88888 d888 888b C88b  d88888 "8" 888 888 "  d88888 
,ee 888 Y888 888P  888   Y888 888P  Y88D  888   ,ee 888 888     888   
"88 888  "88 88"   888    "88 88"  d,dP   888   "88 888 888     888   

]]

hl.on("hyprland.start", function ()
  hl.exec_cmd("noctalia")
  hl.exec_cmd("pgrep -x AmneziaVPN > /dev/null || AmneziaVPN -h")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 20")
end)
