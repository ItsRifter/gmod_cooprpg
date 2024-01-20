--Client side saved config file
HL2C_Client.Config_Changed = HL2C_Client.Config_Changed or false

function HL2C_Client:Config_Update()	--Ensures config is fully populated with vars
	HL2C_Client.Config = HL2C_Client.Config or {}
	HL2C_Client.Config.NewCross = HL2C_Client.Config.NewCross or false
	HL2C_Client.Config.DynamicCross = HL2C_Client.Config.DynamicCross or false
	HL2C_Client.Config.HideXP = HL2C_Client.Config.HideXP or false
	HL2C_Client.Config.CrossType = HL2C_Client.Config.CrossType or 1
	HL2C_Client.Config.UI_Scale = HL2C_Client.Config.UI_Scale or 1
	
	HL2C_Client.Config.HideDmg = HL2C_Client.Config.HideDmg or false
end

function HL2C_Client:Config_Load()
	if HL2C_Debug then print("=HL2C Client Config Loading=") end
	local jsonContent = file.Read("hl2c_data/user_config.txt", "DATA")
	if jsonContent then HL2C_Client.Config = util.JSONToTable(jsonContent) end

	HL2C_Client:Config_Update()
end
HL2C_Client:Config_Load()

function HL2C_Client:Config_Save()
	HL2C_Client:Config_Update()
	if not file.IsDir( "hl2c_data", "DATA") then
		file.CreateDir("hl2c_data", "DATA")
	end
	file.Write("hl2c_data/user_config.txt", util.TableToJSON(HL2C_Client.Config, true))
	if HL2C_Debug then print("=HL2C Client Config Saved=") end
end

if timer.Exists( "HL2C_Config_Tick" ) then timer.Remove( "HL2C_Config_Tick" ) end	
timer.Create( "HL2C_Config_Tick", 3, 0, function() 
	if HL2C_Client.Config_Changed then
		HL2C_Client:Config_Save()
		HL2C_Client.Config_Changed = false
	end
end )

function HL2C_Client:Get_UIScale()
	return 1 - (HL2C_Client.Config.UI_Scale -1)* 0.1
end