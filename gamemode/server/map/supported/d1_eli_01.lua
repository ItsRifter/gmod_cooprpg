HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 36, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_eli_02"


HL2C_Map.Checkpoints = {
	{ min=Vector(30.1,2827.2,-1280.0),max=Vector(-161.2,2814.8,-1196.0),spawn=Vector(-113.3,2771.6,-1280.0),angle=Angle(-5.1,-38.7,0.0)},
	{ min=Vector(531.4,1692.4,-1281.3),max=Vector(380.0,1671.7,-1170.3),spawn=Vector(427.4,1690.8,-1281.3),angle=Angle(1.8,-7.9,0.0)},
	{ min=Vector(638.8,1850.3,-2736.0),max=Vector(336.0,1889.7,-2575.5),spawn=Vector(373.7,1854.4,-2736.0),angle=Angle(2.7,63.1,0.0), dist = 512 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(-61.2,4403.9,-1408.0),angle=Angle(1.0,-141.0,0.0)}

HL2C_Map.Exit = { min=Vector(-485.7,1031.8,-2688.0),max=Vector(-696.0,986.6,-2538.1)}

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-131.0,2212.1,-1246.4),Vector(220.7,3612.5,-1387.9)}

HL2C_Map.MapStartup = function()
	--HL2C_Server:SetVehicle(VEHC_AIRBOAT_GUN)
	--HL2C_Map:RemoveNamedEnts("door_craneladder")
	--HL2C_Map:RemoveMapEnts({1477})	
	
	ents.FindByName("trigger_inner_door")[1]:Fire("AddOutput", "OnStartTouch inner_door:open::0.1:-1")
	ents.FindByName("trigger_inner_door_mossman")[1]:Fire("AddOutput", "OnStartTouch inner_door:open::0.1:-1")
	
	ents.FindByName("trigger_alyxtour01")[1]:Fire("AddOutput", "OnStartTouch lab_exit_door_raven:open::0.1:-1")
	HL2C_Map:RemoveNamedEnts("trigger_alyxtour01_door_close")
	HL2C_Map:RemoveNamedEnts("brush_exit_door_raven_PClip")
	
	HL2C_Map:RemoveNamedEnts("trigger_alyxtour04b")
	
	--HL2C_Map:RemoveMapEnts({1538,1539})	
	--HL2C_Map:FireEnts("canals_portal_elitrans","open")

	
end