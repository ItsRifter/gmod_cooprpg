HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon"}
HL2C_Map.Loadout = {armour = 40, Pistol = 64, SMG1 = 60, A357 = 6, Grenade = 1}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_01a"


HL2C_Map.Checkpoints = {
	{ min=Vector(1921.7,-1528.0,-3790.9),max=Vector(2112.0,-1070.4,-3839.4),spawn=Vector(1975.2,-1429.2,-3821.7),angle=Angle(10.0,76.8,0.0), dist = 1024 },
}

HL2C_Map.Warps = {
	
}

HL2C_Map.Spawn = { spawn=Vector(4534.5,-2728.3,-3768.0),angle=Angle(1.0,99.7,0.0)}

HL2C_Map.Exit = { min=Vector(247.2,223.1,-3328.0),max=Vector(136.0,178.6,-3208.2), func = nil }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(3827.9,-1754.7,-3884.3),Vector(3833.1,-1706.5,-3675.8),Vector(1335.1,-536.0,-3627.9),Vector(138.3,-994.4,-3375.4)}

HL2C_Map.MapStartup = function()
	HL2C_Server:CreateProp("models/hunter/blocks/cube4x8x025.mdl",Vector(992.2,-296.8,-3489.9),Angle(-0.1,179.5,83.7),true)


	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/roller.mdl",Vector(4482.1,-2602.8,-3750.5))
	end

	--HL2C_Map:RemoveNamedEnts("door_craneladder")
	
	--HL2C_Map:RemoveMapEnts({1538,1539})	
	--HL2C_Map:FireEnts("canals_portal_elitrans","open")

	
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
		game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end