function IncludeFolder(path)
	print("Including Folder "..path)
	for k, v in pairs(file.Find("gmod_cooprpg/gamemode/"..path.."*.lua","LUA")) do
		print(path .. v)
		include(path .. v)
	end
end
include("shared.lua")

IncludeFolder("shared/")

--include("client/hud/cl_player_hud.lua")
IncludeFolder("client")
IncludeFolder("client/hud/")