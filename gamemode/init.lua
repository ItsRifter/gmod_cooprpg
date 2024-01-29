include("shared.lua")

IncludeServerFiles("server/")
IncludeServerFiles("server/data/")
IncludeServerFiles("server/player/")
IncludeServerFiles("server/map/")
IncludeServerFiles("server/game/")
IncludeServerFiles("server/network/")

--Order of loading matters
IncludeClientFiles("client/")
IncludeClientFiles("client/data/")
IncludeClientFiles("client/theme/")
IncludeClientFiles("client/tools/")
IncludeClientFiles("client/hud/")
IncludeClientFiles("client/qmenu/")

--adding content files
IncludeContent("materials/hl2c/")
IncludeContent("models/hl2c/")
IncludeContent("sound/hl2c/")