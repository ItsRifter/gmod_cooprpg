include("shared.lua")

IncludeServerFiles("server/")
IncludeServerFiles("server/data/")
IncludeServerFiles("server/player/")
IncludeServerFiles("server/map/")

--Order of loading matters
IncludeClientFiles("client/")
IncludeClientFiles("client/data/")
IncludeClientFiles("client/theme/")
IncludeClientFiles("client/tools/")
IncludeClientFiles("client/hud/")