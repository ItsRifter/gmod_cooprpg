HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon","weapon_shotgun"}
HL2C_Map.Loadout = {armour = 40, Pistol = 64, SMG1 = 60, A357 = 6, Grenade = 1, Buckshot = 6}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_02"

HL2C_Map.Spawn = { spawn=Vector(-3644.4,-584.6,-3584.0),angle=Angle(0.6,-76.2,0.0)}

HL2C_Map.Exit = { min=Vector(-3959.8,24.8,-3336.0),max=Vector(-3465.5,84.9,-3456.0), func = nil }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-1111.1,-788.8,-3635.8),Vector(-1680.0,-2019.9,-3524.3),Vector(-3153.8,-1880.2,-3612.2)}

HL2C_Map.MapStartup = function()

	HL2C_Map.warpA = HL2C_Server:CreateWarp(Vector(-2317.0,-801.0,-3425.1),Vector(-2371.8,-1717.2,-3285.4),Vector(-1689.3,-1065.3,-3384.0),Angle(-1.2,-152.7,0.0))

	HL2C_Server:CreateTrigger(Vector(-2106.0,-1540.4,-3473.4),Vector(-1975.5,-1687.5,-3504.0), function(ent) 
		if not ent:IsPlayer() or not ent:Alive() or not IsHuman(ent) then return false end
		HL2C_Map.warpA:Remove()
		return true
	end,true)

	HL2C_Server:SetExtended(GLOBAL_ON)

	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/roller.mdl",Vector(-3540.3,-732.8,-3568.0))
	end
	
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
		game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end