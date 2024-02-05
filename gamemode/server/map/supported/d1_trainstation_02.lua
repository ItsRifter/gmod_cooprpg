HL2C_Map.Weapons = {}
HL2C_Map.Loadout = {}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_trainstation_03"

HL2C_Map.Spawn = { spawn=Vector(-4314.2,-317.0,-58.4),angle=Angle(-13.2,-91.8,0.0)}

HL2C_Map.Exit = { min=Vector(-5292.6,-4469.3,0.0),max=Vector(-5363.1,-4367.8,128.0), func = nil }

HL2C_Map.VortexChance = 15
HL2C_Map.VortexList = {Vector(-5455.7,-3537.8,82.3)}

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/props_c17/doll01.mdl") then return false end
	game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end


HL2C_Map.MapStartup = function()
	HL2C_Global:SetNoSuit(true)
	game.SetGlobalState("gordon_precriminal", 1)	--temp needed?
end