HL2C_Map.Weapons = {}
HL2C_Map.Loadout = {}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_trainstation_04"

HL2C_Map.Spawn = { spawn=Vector(-5176.0,-4440.0,4.3),angle=Angle(2.5,-89.7,0.0)}

HL2C_Map.Exit = { min=Vector(-5195.4,-4871.3,688.0),max=Vector(-5153.6,-4808.0,553.5), func = nil }

HL2C_Map.Checkpoints = {
	{ min=Vector(-3821.5,-4654.7,504.0),max=Vector(-3976.9,-4568.0,384.2),spawn=Vector(-3904.7,-4406.2,390.9),angle=Angle(0.8,113.9,0.0), dist = 256 },
}

--Trying a mimimal CP aproach by removing block activating triggers.
HL2C_Map.MapStartup = function()
	HL2C_Map:RemoveMapEnts({2026,1929,1982})
	
	game.SetGlobalState("gordon_precriminal", 1)	--temp needed?
end