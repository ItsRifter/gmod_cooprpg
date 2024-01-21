HL2C_Map.Weapons = {"weapon_crowbar"}
HL2C_Map.Loadout = {armour = 20}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_01a"

HL2C_Map.Checkpoints = {
	{ min=Vector(644.3,-6386.9,540.0),max=Vector(678.0,-6652.0,659.5),spawn=Vector(673.0,-6504.3,540.0),angle=Angle(0.8,-68.6,0.0), dist = 512 },
	{ min=Vector(33.0,-2460.7,384.0),max=Vector(73.3,-2335.5,512.0),spawn=Vector(-60.0,-2398.7,432.0),angle=Angle(18.3,-2.0,0.0), dist = 1024  },
}

HL2C_Map.Spawn = { spawn=Vector(673.1,-8285.7,-128.0),angle=Angle(0.8,92.4,0.0)}

HL2C_Map.Exit = { min=Vector(555.0,3475.2,14.5),max=Vector(811.9,3557.7,-96.0), func = nil }

--HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(475.8,-178.9,51.8),Vector(673.6,-3465.5,275.8)}

HL2C_Map.MapStartup = function()
	HL2C_Map:RemoveMapEnts({1332,2364})	
end