HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 27, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_10"

HL2C_Map.Checkpoints = {

}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(7690.3,9294.6,-450.4),angle=Angle(-1.4,91.0,0.0)}

HL2C_Map.Exit = { min=Vector(-1344.0,-7968.5,-427.0),max=Vector(-1856.0,-7821.0,-174.4), func = nil }

HL2C_Map.VortexChance = 30	--defaults if not set
HL2C_Map.VortexList = {Vector(3319.9,-8704.5,-394.6),Vector(12975.9,-1055.2,-393.6),Vector(1557.5,8831.1,-267.1)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT)

	--HL2C_Map:RemoveMapEnts({1825})	
	
	HL2C_Map:RemoveMapEnts({1397,1398,1399,1400})	
	HL2C_Map:FireEnts("areaportal_1","open")
end