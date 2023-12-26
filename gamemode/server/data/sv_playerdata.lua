local hl2c_player = FindMetaTable("Player")

HL2C_Server.DataSystem = HL2C_Server.DataSystem or {}

function HL2C_Server.DataSystem:InitPlayerData(ply)
	ply.hl2c_data = ply.hl2c_data or {}
	ply.hl2c_data.Name = ply.hl2c_data.Name or ply:Nick()
	ply.data_loaded = true
end

function HL2C_Server.DataSystem:SavePlayerData(ply)
	if ply:IsBot() or not ply.loaded then return end

	local playerID = string.Replace(ply:SteamID(), ":", "!")

	--Store all persistent data in players hl2c_data object as JSON
	file.Write("hl2c_data/" .. playerID .. ".txt", util.TableToJSON(ply.hl2c_data, true))
end

function HL2C_Server.DataSystem:LoadPlayerData(ply)
	if ply:IsBot() then return false end

	local playerID = string.Replace(ply:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2c_data/" .. playerID .. ".txt", "DATA")
	if not jsonContent then return false end

	--Read players hl2c_data from JSON
	ply.hl2c_data = util.JSONToTable(jsonContent)

	ply:InitData()	--initialises any extra data not in save
end

function HL2C_Server.DataSystem:GetData(ply)
	//if ply.data_loaded then return end

	-- if not ply:LoadData() then 
	-- 	ply:InitData()
	-- 	ply:SaveData()
	-- end
end

--------------------------------------------------------------

hook.Add("PlayerInitialSpawn", "HL2C_Data_Check", function(ply)
	//ply:GetPlayerData()
end)

hook.Add("PlayerDisconnected", "HL2C_Data_Save_Disconnect", function(ply)
	//ply:SavePlayerData()
end)

hook.Add( "ShutDown", "HL2C_Data_Save_MapChange", function() 
	//for _, ply in ipairs( player.GetAll() ) do
		//if ply:IsBot() then continue end

		//ply:SavePlayerData()
	//end
end)

--------------------------------------------------------------

hook.Add("Initialize", "HL2C_Data_CheckFolder", function()
	
	if not file.IsDir( "hl2c_data", "DATA") then
		HL2C_Server:DebugMsg("Creating new data folder", HL2C_COLOR_STANDARD)
		file.CreateDir("hl2c_data", "DATA")
	end
end)
	