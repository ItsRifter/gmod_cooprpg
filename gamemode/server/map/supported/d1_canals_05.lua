HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1"}
HL2C_Map.Loadout = {armour = 30,Pistol = 18,SMG1 = 30}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_06"

HL2C_Map.Checkpoints = {
	{ min=Vector(4004.9,3640.0,-410.1),max=Vector(4436.1,4308.9,-440.8),spawn=Vector(4243.0,3949.7,-461.3),angle=Angle(6.1,-92.4,0.0), dist = 1024 },
	{ min=Vector(7005.2,1280.4,-320.0),max=Vector(7051.2,1600.0,-496.8),spawn=Vector(6991.0,1567.2,-438.7),angle=Angle(4.4,-2.1,0.0), dist = 1024 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(3518.0,6659.1,-288.0),angle=Angle(4.6,-111.3,0.0)}

HL2C_Map.Exit = { min=Vector(-4137.4,-2496.0,-509.9),max=Vector(-4212.7,-2112.0,-321.0), func = nil }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(3294.5,7609.0,-333.1),Vector(3822.7,4138.3,-237.7),Vector(1028.5,111.2,-451.1)}

HL2C_Map.MapStartup = function()
	HL2C_Map:RemoveMapEnts({1672})	
	
	--HL2C_Server:CreateProp("models/props_wasteland/cargo_container01.mdl",Vector(170,-120,-708),Angle(0,0,0))

	--HL2C_Map:FireEnts("underground_portal_slippery02","open")
end