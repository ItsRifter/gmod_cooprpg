HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1"}
HL2C_Map.Loadout = {armour = 30,Pistol = 18,SMG1 = 45}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_07"

HL2C_Map.Checkpoints = {
	{ min=Vector(-512.0,5813.9,-3.4),max=Vector(512.0,6126.0,-255.1),spawn=Vector(264.3,5885.8,-145.5),angle=Angle(-1.9,111.5,0.0), dist = 1024 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(12219.0,8880.3,-163.3),angle=Angle(2.8,168.1,0.0)}

HL2C_Map.Exit = { min=Vector(-2592.0,-2561.6,-510.3),max=Vector(-2678.3,-3584.0,-144.2), func = nil }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-1451.9,5433.8,-113.3),Vector(-6715.5,4214.3,-212.6)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT)

	HL2C_Server:CreateProp("models/props_vehicles/car005b.mdl",Vector(-375.3,5582.2,-215.0),Angle(1.0,-3.1,-91.1))
	HL2C_Server:CreateProp("models/props_pipes/pipecluster32d_001a.mdl",Vector(-487.0,5528.9,-192.7),Angle(0.0,-0.0,0.0))


	--HL2C_Map:RemoveMapEnts({1672})	
	
	--HL2C_Server:CreateProp("models/props_wasteland/cargo_container01.mdl",Vector(170,-120,-708),Angle(0,0,0))

	--HL2C_Map:FireEnts("underground_portal_slippery02","open")
end