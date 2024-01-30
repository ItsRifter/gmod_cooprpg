HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1"}
HL2C_Map.Loadout = {armour = 45,Pistol = 18,SMG1 = 45}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_08"

local function SpawnBarrelPoint()
	HL2C_Server:CreateProp("models/props_c17/oildrum001_explosive.mdl",Vector(6844.3,1333.1,-268.6),Angle(-0.1,64.6,-0.0))
	HL2C_Server:CreateProp("models/props_c17/oildrum001_explosive.mdl",Vector(6837.7,1287.2,-268.7),Angle(-0.1,43.8,-0.0))
	
	HL2C_Map:SetMapEntsHealth({1502,1503,1505,1506,1507,1508,1509,1511,1532,1533,1510},50)
end

HL2C_Map.Checkpoints = {
	{ min=Vector(11261.5,2020.2,-256.0),max=Vector(11327.2,2240.0,-94.9),spawn=Vector(11284.0,1939.2,-256.0),angle=Angle(4.8,87.0,0.0), dist = 1024 },
	{ min=Vector(7106.5,1501.7,-320.0),max=Vector(7537.1,1414.0,-131.3),spawn=Vector(7133.4,1518.4,-320.0),angle=Angle(2.9,-18.7,0.0), func = function() SpawnBarrelPoint() end, dist = 512},
	{ min=Vector(6662.6,640.0,-298.8),max=Vector(6402.8,1408.0,-510.7),spawn=Vector(6550.4,843.8,-467.1),angle=Angle(-6.3,-132.6,0.0), dist = 2048 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(7904.9,7774.2,-439.3),angle=Angle(-1.0,19.9,0.0)}

HL2C_Map.Exit = { min=Vector(-7391.9,-3840.0,-1035.8),max=Vector(-7146.6,-4544.0,-786.0) }

HL2C_Map.VortexChance = 30	--defaults if not set
HL2C_Map.VortexList = {Vector(-11154.1,-8284.1,-969.2),Vector(-2844.5,-6176.5,-748.2),Vector(7641.1,1368.5,-464.9),Vector(7736.2,1907.9,-156.8)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT)
	
	HL2C_Map:RemoveMapEnts({2669,2239,2238})	

	HL2C_Server:CreateProp("models/props_debris/metal_panel02a.mdl",Vector(7461.1,1405.3,-193.0),Angle(3.4,89.6,2.2))
	HL2C_Server:CreateProp("models/props_debris/metal_panel01a.mdl",Vector(7573.7,1383.6,-197.7),Angle(-0.5,-0.1,0.3))
	HL2C_Server:CreateProp("models/props_debris/metal_panel01a.mdl",Vector(7573.8,1335.1,-193.5),Angle(-0.6,-0.0,1.0))

	HL2C_Map:SetMapEntsHealth({1502,1503,1505,1506,1507,1508,1509,1511,1532,1533,1510},9999)

	--ents.GetMapCreatedEntity(1502):SetHealth( 9999 )
	--ents.GetMapCreatedEntity(1509):SetHealth( 9999 )
	--ents.GetMapCreatedEntity(1511):SetHealth( 9999 )

	HL2C_Map:RemoveMapEnts({2468,2072})	
	HL2C_Map:FireEnts("canals_areaportal_spillway01","open")
end