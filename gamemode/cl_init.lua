-- function IncludeFolder(path)
-- 	print("Including Folder "..path)
-- 	for k, v in pairs(file.Find("gmod_cooprpg/gamemode/"..path.."*.lua","LUA")) do
-- 		print(path .. v)
-- 		include(path .. v)
-- 	end
-- end

-- IncludeClientFiles("shared.lua", true)

-- IncludeClientFiles("shared/", true)

-- --include("client/hud/cl_player_hud.lua")
-- IncludeClientFiles("client", true)
-- IncludeClientFiles("client/hud/", true)