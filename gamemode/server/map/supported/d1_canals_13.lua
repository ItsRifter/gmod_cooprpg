HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 36, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_eli_01"


HL2C_Map.Checkpoints = {

}

HL2C_Map.Warps = {
	{ min=Vector(989.1,-5393.1,-211.6),max=Vector(-3775.5,-5356.1,-2133.5),spawn=Vector(-148.6,-3768.5,-256.0),angle=Angle(4.5,152.3,0.0) },
}

HL2C_Map.Spawn = { spawn=Vector(-10604.2,3702.0,-387.8),angle=Angle(-2.3,-104.3,0.0)}

HL2C_Map.Exit = { min=Vector(-1516.9,-3884.8,-439.9),max=Vector(29.4,-4583.3,-560.9), func = function(cp,ply)
	ply:UpdateAchievementProgress("HL2_Canals", 13)
end }

--HL2C_Map.VortexChance = 25	--defaults if not set
--HL2C_Map.VortexList = {Vector(-10326.9,-2541.3,-315.2),Vector(-1770.3,3923.1,-387.1)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT_GUN)
	HL2C_Map:RemoveNamedEnts("door_craneladder")
	
	HL2C_Map:RemoveMapEnts({1538,1539})	
	HL2C_Map:FireEnts("canals_portal_elitrans","open")
	HL2C_Map:FireEnts("canals_portal_helihouse01","open")
	HL2C_Map:FireEnts("canals_portal_08atunnel","open")
	
end