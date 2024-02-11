function HL2C_Data:InitPlayerData(ply)
	ply.hl2c_data = ply.hl2c_data or {}
	local data = ply.hl2c_data
	
	data.Name = data.Name or ply:Nick()
	
	data.Level 	= data.Level or 0
	data.Exp 	= data.Exp or 0
	data.Next 	= data.Next or HL2C_Server:ExpRequired(0)
	
	data.Achievements = data.Achievements or {}
	data.AchProgress = data.AchProgress or {}
	
	HL2C_Ach:SendAchievements(ply)
	
	ply:SetNWInt("hl2c_stat_exp", data.Exp)
	ply:SetNWInt("hl2c_stat_level", data.Level)
	ply:SetNWInt("hl2c_stat_expreq", data.Next)
	
	ply.data_loaded = true
	
	HL2C_Data:PlayerDataExtra(ply)
end

function HL2C_Data:PlayerDataExtra(ply)	--player stuff that doesnt get saved but want to track
	ply.damagexp = 0
end