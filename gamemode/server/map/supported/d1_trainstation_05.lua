HL2C_Map.Weapons = {}
HL2C_Map.Loadout = {}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_trainstation_06"

HL2C_Map.Spawn = { spawn=Vector(-5413.2,-864.6,72.1),angle=Angle(3.7,-178.9,0.0)}

HL2C_Map.Exit = { min=Vector(-10687.2,-3642.8,320.0),max=Vector(-10494.9,-3494.1,502.3), func = nil }

HL2C_Map.Checkpoints = {
	{ min=Vector(-6558.5,-1126.0,0.0),max=Vector(-6352.0,-1208.0,136.0),spawn=Vector(-6503.5,-1153.3,0.0),angle=Angle(2.3,-106.4,0.0), dist = 96 },
	{ min=Vector(-7091.6,-1477.0,99.2),max=Vector(-7121.4,-1277.4,0.0),spawn=Vector(-7144.5,-1403.9,0.0),angle=Angle(-3.5,169.8,0.0), dist = 64 },
	{ min=Vector(-10248.4,-4688.0,426.8),max=Vector(-10443.5,-4742.3,320.0),spawn=Vector(-10374.3,-4714.9,320.0),angle=Angle(15.9,-165.7,0.0), func = nil },
}

HL2C_Map.VortexChance = 20
HL2C_Map.VortexList = {Vector(-6802.4,-1641.6,216.4),Vector(-6368.6,-1583.9,203.5),Vector(-7088.0,-1262.9,202.1),Vector(-10962.1,-5353.4,339.8)}

HL2C_Map.MapStartup = function()
	HL2C_Map:RemoveMapEnts({2404})	--end door closer

	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/props_c17/doll01.mdl",Vector(-5518,-879,72))
	end
end