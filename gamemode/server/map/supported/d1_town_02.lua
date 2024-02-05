HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon"}
HL2C_Map.Loadout = {armour = 40, Pistol = 64, SMG1 = 60, A357 = 6, Grenade = 1}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_03"


HL2C_Map.Checkpoints = {

}

HL2C_Map.Warps = {
	
}

HL2C_Map.Spawn = { spawn=Vector(-812.9,830.7,-3440.0),angle=Angle(6.9,-175.3,0.0)}

HL2C_Map.Exit = { min=Vector(-3587.5,-446.4,-3416.0),max=Vector(-3711.7,-466.8,-3584.0), func = nil }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-2330.4,-103.4,-3435.8)}

HL2C_Map.MapStartup = function()
	--HL2C_Server:CreateProp("models/hunter/blocks/cube075x4x075.mdl",Vector(14.6,575.6,-3266.3),Angle(-17.8,126.3,-72.3),true)

	if HL2C_Server:IsExtended() then
		HL2C_Server:MoveSpawn(Vector(-3708.6,-20.3,-3456.0),Angle(1.8,81.1,0.0))
		HL2C_Server:SpawnExit(Vector(-5113.9,2078.9,-3251.6),Vector(-5316.7,2026.3,-3085.3),nil)
		
		HL2C_Map.VortexList = {Vector(-4280.7,1088.1,-3442.6),Vector(-5673.2,730.2,-3243.9)}
		
		HL2C_Map.NextMap = "d1_town_02a"
		
		HL2C_Server:AddWeaponRespawns("weapon_shotgun",nil,nil)
		HL2C_Map.Loadout = {armour = 40, Pistol = 64, SMG1 = 60, A357 = 6, Grenade = 1, Buckshot = 6}
		
		if HL2C_Server:BringItem() then
			HL2C_Server:SpawnItem("models/roller.mdl",Vector(-3603.6,298.3,-3439.8))
		end
	else
		HL2C_Map.warpA = HL2C_Server:CreateWarp(Vector(-2838.9,-464.0,-3389.7),Vector(-3584.0,829.2,-3235.1),Vector(-2442.3,631.3,-3377.9),Angle(-3.0,178.5,0.0))

		HL2C_Server:CreateTrigger(Vector(-2992.0,960.0,-3370.9),Vector(-2880.4,844.0,-3361.5), function(ent) 
			if not ent:IsPlayer() or not ent:Alive() or not IsHuman(ent) then return false end
			HL2C_Map.warpA:Remove()
			return true
		end,true)
	
		if HL2C_Server:BringItem() then
			HL2C_Server:SpawnItem("models/roller.mdl",Vector(-962.0,883.9,-3425.0))
		end
	end

	--HL2C_Map:RemoveNamedEnts("door_craneladder")
	
	--HL2C_Map:RemoveMapEnts({1538,1539})	
	HL2C_Map:FireEnts("churchyard_portal","open")

	
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
		game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end