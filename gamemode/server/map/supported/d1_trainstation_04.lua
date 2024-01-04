
HL2C_Map.Weapons = {}
HL2C_Map.Loadout = {}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_trainstation_05"

HL2C_Map.Spawn = { spawn=Vector(-3367.7,-3670.5,448.0), angle=Angle(-13.3,88.5,0.0)}

HL2C_Map.Exit = { min=Vector(-8110.7,-4160.0,-154.2), max=Vector(-8019.4,-4097.0,-256.0), func = nil }

HL2C_Map.Checkpoints = {
	{ min=Vector(-4099.1,-3107.4,518.2), max=Vector(-4442.3,-3638.9,776.7), spawn=Vector(-4134.3,-3348.1,512.0), angle=Angle(-9.0,-172.4,0.0)},
	{ min=Vector(-7074.5,-3921.6,384.0), max=Vector(-7416.1,-4048.0,490.2), spawn=Vector(-7219.7,-4016.2,384.0), angle=Angle(0.3,174.7,0.0) },
	{ min=Vector(-7807.9,-3884.0,-223.2), max=Vector(-7371.6,-4085.1,-256.0), spawn=Vector(-7758.5,-3949.3,-235.6), angle=Angle(6.1,-12.6,0.0) }
}

HL2C_Map.MapStartup = function()
	print("Map startup code was here")
end