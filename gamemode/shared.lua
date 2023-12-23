AddCSLuaFile()

GM.Name = "Half-Life 2: Co-Op Synergized"
GM.Author = "ItsRifter"
GM.Email = "dontspam_me@goaway.com"
GM.Website = "N/A"

GM.ServerName = GetHostName()

function IncludeClientFiles(path)
	for k, v in pairs(file.Find(GM.FolderName .. "/gamemode/" ..path.. "*.lua","LUA")) do
		if SERVER then
			AddCSLuaFile(path .. v)
		else
			include(path .. v)
		end
	end
end

function IncludeServerFiles(path)
	for k, v in pairs(file.Find(GM.FolderName .. "/gamemode/" ..path.. "*.lua","LUA")) do
		include(path .. v)
	end
end

function IncludeSharedFiles(path)
	for k, v in pairs(file.Find(GM.FolderName .. "/gamemode/" ..path.. "*.lua","LUA")) do
		include(path .. v)
		AddCSLuaFile(path .. v)
	end
end

IncludeSharedFiles("shared/")

HL2C_Global = HL2C_Global or {}

if SERVER then
    HL2C_Server = HL2C_Server or {}
end

if CLIENT then
    HL2C_Client = HL2C_Client or {}
end