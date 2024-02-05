HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon"}
HL2C_Map.Loadout = {armour = 40, Pistol = 64, SMG1 = 60, A357 = 6, Grenade = 1}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_02"


HL2C_Map.Checkpoints = {

}

HL2C_Map.Warps = {
	
}

HL2C_Map.Spawn = { spawn=Vector(204.5,300.2,-3328.0),angle=Angle(4.2,-94.7,0.0)}

HL2C_Map.Exit = { min=Vector(-673.6,649.1,-3440.0),max=Vector(-589.9,768.0,-3291.1), func = nil }

HL2C_Map.VortexChance = 30	--defaults if not set
HL2C_Map.VortexList = {Vector(-647.1,602.4,-3539.1),Vector(20.7,-571.3,-3244.0)}

HL2C_Map.MapStartup = function()
	HL2C_Server:CreateProp("models/hunter/blocks/cube075x4x075.mdl",Vector(14.6,575.6,-3266.3),Angle(-17.8,126.3,-72.3),true)

	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/roller.mdl",Vector(152.0,170.6,-3309.7))
	end

	HL2C_Map:FireEnts("portalwindow_03_portal","open")
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
		game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end