local hl2c_player = FindMetaTable("Player")

function hl2c_player:InitData()
	self.hl2c_data = self.hl2c_data or {}
	self.hl2c_data.Name = self.hl2c_data.Name or self:Nick()
	self.loaded = true
end

function hl2c_player:SaveData()
	if self:IsBot() then return end
	if not self.loaded then return false end
	local PlayerID = string.Replace(self:SteamID(), ":", "!")
	--Store all persistent data in players hl2c_data object as JSON
	file.Write("hl2c_data/" .. PlayerID .. ".txt", util.TableToJSON(self.hl2c_data, true))
end

function hl2c_player:LoadData()
	if self:IsBot() then return false end

	local PlayerID = string.Replace(self:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2c_data/" .. PlayerID .. ".txt", "DATA")
	if not jsonContent then return false end

	--Read players hl2c_data from JSON
	self.hl2c_data = util.JSONToTable(jsonContent)
	self:InitData()	--initialises any extra data not in save
end

function hl2c_player:GetData()
	if self.loaded then return end
	if not self:LoadData() then 
		self:InitData() 
		self:SaveData()
	end
end

--------------------------------------------------------------

hook.Add("PlayerInitialSpawn", "HL2C_NewPlayerCheck", function(ply)
	ply:GetData()
end)

hook.Add( "ShutDown", "HL2CR_MapChangeSave", function() 
	for _, ply in ipairs( player.GetAll() ) do
		if ply:IsBot() then continue end

		ply:SaveData()
	end
end)

--------------------------------------------------------------

hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2c_data", "DATA") then
		print("MISSING HL2C FOLDER: Making new one\n")
		file.CreateDir("hl2c_data", "DATA")
	end
end)
	