HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 36, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_13"


HL2C_Map.Checkpoints = {
	{ min=Vector(-3328.0,4743.1,228.7),max=Vector(-2688.0,5044.0,637.2),spawn=Vector(-3181.0,5545.6,416.3),angle=Angle(4.6,-85.2,0.0), dist = 4096 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(12010.9,9619.8,547.9),angle=Angle(8.6,97.1,0.0)}

HL2C_Map.Exit = { min=Vector(2613.3,-8512.9,96.0),max=Vector(2239.8,-8578.5,480.0), func = function(cp,ply)
	ply:UpdateAchievementProgress("HL2_Canals", 12)
end }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(7661.2,8058.6,433.6),Vector(-6689.8,4154.5,596.2),Vector(4621.7,-4085.8,163.5)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT_GUN)
	
	HL2C_Map:RemoveMapEnts({1939,1940,1888,1889,1890,1891})	
	HL2C_Map:FireEnts("portal_2apc_pipeentrance","open")
	HL2C_Map:FireEnts("portal_2apc_entrance","open")
	HL2C_Map:FireEnts("portal_2apc_exit1","open")
	HL2C_Map:FireEnts("portal_2apc_exit2","open")
	HL2C_Map:FireEnts("canals_portal_08atunnel","open")

	HL2C_Server:CreateProp("models/props_wasteland/cargo_container01b.mdl",Vector(1541.5,-4145.1,253.8),Angle(15.1,91.9,7.2))
	HL2C_Server:CreateProp("models/props_wasteland/rockgranite03c.mdl",Vector(1424.0,-4103.2,177.5),Angle(4.6,174.4,-102.6))

	HL2C_Server:CreateProp("models/props_wasteland/cargo_container01c.mdl",Vector(933.0,-4148.1,241.5),Angle(-19.9,-93.1,-177.4))
	HL2C_Server:CreateProp("models/props_wasteland/rockcliff01k.mdl",Vector(1077.8,-4151.0,162.8),Angle(9.4,-96.1,109.8))
	HL2C_Server:CreateProp("models/props_wasteland/rockcliff01c.mdl",Vector(834.1,-4108.3,132.2),Angle(12.7,80.3,74.1))

end