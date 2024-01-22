HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol"}
HL2C_Map.Loadout = {armour = 20,Pistol = 18}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_02"

HL2C_Map.Checkpoints = {
	{ min=Vector(-1792.0,4654.7,-111.6),max=Vector(-1408.0,4608.9,93.0),spawn=Vector(-1571.3,4535.8,-128.0),angle=Angle(-5.8,-121.0,0.0), dist = 1024 },
	{ min=Vector(-2928.0,8644.6,-10.7),max=Vector(-2752.0,8692.8,190.6),spawn=Vector(-2828.8,8651.2,20.4),angle=Angle(3.3,90.6,0.0), dist = 1024 },
}

HL2C_Map.Spawn = { spawn=Vector(718.2,3271.4,-96.0),angle=Angle(-0.2,88.7,0.0)}

HL2C_Map.Exit = { min=Vector(-5586.5,9136.2,160.0),max=Vector(-5645.1,9296.0,-16.2) }

HL2C_Map.VortexChance = 20	--defaults if not set
HL2C_Map.VortexList = {Vector(-2170.5,5990.1,34.0),Vector(528.6,3527.9,165.7),Vector(327.5,6192.5,-24.7)}

HL2C_Map.MapStartup = function()
	--HL2C_Map:RemoveMapEnts({1332,2364})	
end