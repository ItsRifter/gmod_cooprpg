include("shared.lua")

function AddClientCSFolder(path)
	print("Adding Folder "..path)
	for k, v in pairs(file.Find("gmod_cooprpg/gamemode/"..path.."*.lua","LUA")) do
		print(path .. v)
		AddCSLuaFile(path .. v)
	end
end

function IncludeFolder(path)
	print("Including Folder "..path)
	for k, v in pairs(file.Find("gmod_cooprpg/gamemode/"..path.."*.lua","LUA")) do
		print(path .. v)
		include(path .. v)
	end
end

function SharedFolder(path)
	print("Sharing Folder "..path)
	for k, v in pairs(file.Find("gmod_cooprpg/gamemode/"..path.."*.lua","LUA")) do
		print(path .. v)
		include(path .. v)
		AddCSLuaFile(path .. v)
	end
end

//SERVER FILES
include("server/player/sv_player_setup.lua")
include("server/map/sv_map_setup.lua")

//SHARED FOLDERS
AddClientCSFolder("shared/")

//CLIENT FOLDERS
AddClientCSFolder("client/")
AddClientCSFolder("client/hud/")
--AddCSLuaFile("client/hud/cl_player_hud.lua")