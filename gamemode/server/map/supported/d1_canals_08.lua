HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1"}
HL2C_Map.Loadout = {armour = 40,Pistol = 27,SMG1 = 45,Grenade=1}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_09"

HL2C_Map.Checkpoints = {
	{ min=Vector(-511.0,-246.9,-592.0),max=Vector(-259.0,-0.0,-437.6),spawn=Vector(-466.3,-197.0,-592.0),angle=Angle(-2.8,104.7,0.0), dist = 2048 },
	{ min=Vector(-6528.0,-2922.7,-670.6),max=Vector(-5952.0,-2733.2,-383.2),spawn=Vector(-6374.2,-3069.1,-557.6),angle=Angle(11.1,80.8,0.0), dist = 2048 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(7820.8,-11120.2,-419.5),angle=Angle(3.1,-23.6,0.0)}

HL2C_Map.Exit = { min=Vector(-9201.8,8389.0,-579.3),max=Vector(-8816.0,8247.5,-357.8), func = nil }

HL2C_Map.VortexChance = 35	--defaults if not set
HL2C_Map.VortexList = {Vector(-1607.3,-1914.4,-256.8),Vector(-1123.8,-32.7,-365.7),Vector(-7061.0,2732.5,-576.6)}

HL2C_Map.MapStartup = function()

	HL2C_Map:RemoveMapEnts({1825})	
	
	HL2C_Map:RemoveMapEnts({2179,2178,1860,1859})	
	HL2C_Map:FireEnts("portal_dockstairs","open")
end