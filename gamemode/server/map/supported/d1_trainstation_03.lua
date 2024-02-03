HL2C_Map.Weapons = {}
HL2C_Map.Loadout = {}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_trainstation_04"

HL2C_Map.Spawn = { spawn=Vector(-5176.0,-4440.0,4.3),angle=Angle(2.5,-89.7,0.0)}

HL2C_Map.Exit = { min=Vector(-5195.4,-4871.3,688.0),max=Vector(-5153.6,-4808.0,553.5), func = nil }

HL2C_Map.Checkpoints = {
	{ min=Vector(-3821.5,-4654.7,504.0),max=Vector(-3976.9,-4568.0,384.2),spawn=Vector(-3904.7,-4406.2,390.9),angle=Angle(0.8,113.9,0.0), dist = 256 },
}

HL2C_Map.VortexChance = 15
HL2C_Map.VortexList = {Vector(-5108.6,-4853.4,20.0),Vector(-3959.7,-4747.0,303.2)}

--Trying a mimimal CP aproach by removing block activating triggers.
HL2C_Map.MapStartup = function()
	HL2C_Global:SetNoSuit(true)
	HL2C_Map:RemoveMapEnts({2026,1929,1982})
	
	game.SetGlobalState("gordon_precriminal", 1)	--temp needed?
	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/props_c17/doll01.mdl",Vector(-5196.0,-4535.6,9.3))
	end
end

HL2C_Map.ExitModel = function(ent)
	if not ent:GetClass() == "models/props_c17/doll01.mdl" then return false end
	game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end