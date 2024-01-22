HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol"}
HL2C_Map.Loadout = {armour = 20,Pistol = 18}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_03"

HL2C_Map.Checkpoints = {
	{ min=Vector(-143.6,-1107.4,-848.0),max=Vector(-81.2,-1016.3,-704.0),spawn=Vector(-109.4,-1063.6,-848.0),angle=Angle(1.0,90.3,0.0), dist = 1024},
}

HL2C_Map.Warps = {
	{ min=Vector(3274.3,-2338.7,-673.0),max=Vector(2576.6,-2406.2,-384.0),spawn=Vector(2781.1,-2140.8,-620.2),angle=Angle(-0.5,78.3,0.0)},
}

HL2C_Map.Spawn = { spawn=Vector(2969.6,-2116.8,-640.0),angle=Angle(0.0,97.7,0.0)}

HL2C_Map.Exit = { min=Vector(-469.1,1550.9,-831.8),max=Vector(-580.2,1527.5,-720.3), func = nil }

HL2C_Map.VortexChance = 20	--defaults if not set
HL2C_Map.VortexList = {Vector(384.4,252.7,-872.7),Vector(-1032.2,-1147.4,-778.1)}

HL2C_Map.MapStartup = function()
	HL2C_Map:RemoveMapEnts({1440,1441,1444,1621,1622,1623,1496})	
	
	HL2C_Server:CreateProp("models/props_wasteland/cargo_container01.mdl",Vector(170,-120,-708),Angle(0,0,0))
	HL2C_Server:CreateProp("models/props_debris/beam01c.mdl",Vector(236.1,-299.8,-760.0),Angle(-88.3,-174.4,86.2))
	HL2C_Server:CreateProp("models/props_debris/beam01d.mdl",Vector(120.0,-284.0,-758.6),Angle(-9.3,179.7,-11.8))

	HL2C_Map:RemoveMapEnts({1554,1550})
	HL2C_Map:FireEnts("underground_portal_slippery01","open")
	HL2C_Map:FireEnts("underground_portal_slippery02","open")
end