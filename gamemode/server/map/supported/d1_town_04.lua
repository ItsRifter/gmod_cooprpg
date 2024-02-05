HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon","weapon_shotgun"}
HL2C_Map.Loadout = {armour = 40, Pistol = 45, SMG1 = 45, A357 = 6, Grenade = 1, Buckshot = 12}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_05"


HL2C_Map.Checkpoints = {
	{ min=Vector(2033.0,16.0,-5650.8),max=Vector(1807.9,240.0,-5573.0),spawn=Vector(1877.2,152.0,-5776.8),angle=Angle(1.7,-86.2,0.0), dist = 2048 },
}

HL2C_Map.Spawn = { spawn=Vector(1037.8,-1283.3,-3648.0),angle=Angle(2.3,169.3,0.0)}

HL2C_Map.Exit = { min=Vector(-2559.1,1279.7,-4864.0),max=Vector(-2531.6,1024.1,-4736.0), func = nil }

--HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(620.4,-1500.4,-3500.3),Vector(709.1,-1967.4,-4789.8)}

HL2C_Map.MapStartup = function()
	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/roller.mdl",Vector(913.0,-1296.0,-3634.2))
	end
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
		--Goodbye rollerball
	return true
end