if SERVER then AddCSLuaFile() end

hl2c_player = FindMetaTable("Player")

--HL2C_Debug = true  --Uncomment to show files loading and other spam logging messages
HL2C_DebugTools = true

HL2C_Global = HL2C_Global or {}

if SERVER then
    HL2C_Server = HL2C_Server or {}
	HL2C_Data = HL2C_Data or {}
	
	function IncludeContent(path)
		if HL2C_Debug then print("===Including content path=== "..path) end
		for k, v in pairs(file.Find(path.. "*.*","GAME")) do
			if HL2C_Debug then print("= "..v) end
			resource.AddFile(path .. v);
		end
	end
	
end

if CLIENT then
    HL2C_Client = HL2C_Client or {}
end

GM.Name = "Half-Life 2: Co-Op Synergized"
GM.Author = "ItsRifter"
GM.Email = "dontspam_me@goaway.com"
GM.Website = "N/A"

GM.ServerName = GetHostName()

function IncludeClientFiles(path)
	if HL2C_Debug then print("===Including client path=== "..path) end
	for k, v in pairs(file.Find(GM.FolderName .. "/gamemode/" ..path.. "*.lua","LUA")) do
		if HL2C_Debug then print("= "..v) end
		if SERVER then
			AddCSLuaFile(path .. v)
		else
			include(path .. v)
		end
	end
end

function IncludeServerFiles(path)
	if HL2C_Debug then print("===Including server path=== "..path) end
	for k, v in pairs(file.Find(GM.FolderName .. "/gamemode/" ..path.. "*.lua","LUA")) do
		if HL2C_Debug then print("= "..v) end
		include(path .. v)
	end
end

function IncludeSharedFiles(path)
	if HL2C_Debug then print("===Including shared path=== "..path) end
	for k, v in pairs(file.Find(GM.FolderName .. "/gamemode/" ..path.. "*.lua","LUA")) do
		if HL2C_Debug then print("= "..v) end
		include(path .. v)
		if SERVER then AddCSLuaFile(path .. v) end
	end
end

IncludeSharedFiles("shared/")
IncludeSharedFiles("shared/data/")
IncludeSharedFiles("shared/progression/")
IncludeSharedFiles("shared/progression/achievements/")