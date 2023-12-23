include("shared.lua")

IncludeServerFiles("server/")
IncludeServerFiles("server/player/")
IncludeServerFiles("server/map/")

--Order of loading matters
IncludeClientFiles("client/")
IncludeClientFiles("client/data/")
IncludeClientFiles("client/theme/")
IncludeClientFiles("client/hud/")