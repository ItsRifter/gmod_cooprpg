HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon","weapon_shotgun"}
HL2C_Map.Loadout = {armour = 40, Pistol = 30, SMG1 = 60, A357 = 6, Grenade = 2, Buckshot = 12}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d2_coast_01"

HL2C_Map.Spawn = { spawn=Vector(-11114.8,4258.8,896.0),angle=Angle(-1.8,171.0,0.0)}

HL2C_Map.Exit = { min=Vector(-1727.7,10977.2,896.0),max=Vector(-1632.7,10909.7,1016.0), func = nil }

HL2C_Map.Checkpoints = {
	{ min=Vector(-3410.0,7752.7,896.0),max=Vector(-3325.8,7295.8,1216.0),spawn=Vector(-3472.3,7679.2,911.0),angle=Angle(-2.0,-21.8,0.0), dist = 4096 },
}

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(25.4,7725.5,916.2),Vector(-12018.3,6249.2,916.2),Vector(-12324.2,3651.5,916.2)}

HL2C_Map.MapStartup = function()
	HL2C_Map:RemoveNamedEnts("trigger_close_door")
	HL2C_Map:RemoveNamedEnts("trigger_changelevel")
	

end

