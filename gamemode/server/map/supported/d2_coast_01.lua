HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon","weapon_shotgun","weapon_ar2"}
HL2C_Map.Loadout = {armour = 40, Pistol = 30, SMG1 = 60, A357 = 6, Grenade = 2, Buckshot = 6, AR2 = 30}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d2_coast_02"

HL2C_Map.Spawn = { spawn=Vector(-7859.3,-10187.8,896.0),angle=Angle(0.4,88.1,0.0)}

HL2C_Map.Exit = { min=Vector(-12096.0,3210.6,1536.7),max=Vector(-11589.3,3394.5,1792.0), func = nil }

HL2C_Map.Checkpoints = {

}

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-13186.6,-3773.2,1243.4),Vector(-7103.0,-11157.2,552.5)}

HL2C_Map.MapStartup = function()
	--HL2C_Server:SetVehicle(VEHC_NONE)
	HL2C_Map:RemoveNamedEnts("trigger_didntgetinjeep")	--shut up

	--fixes the jump for vehicles
	HL2C_Map:RemoveMapEnts({1847})	
	HL2C_Map:FireEnts("push_car_superjump_01","enable")

	HL2C_Server:CreateProp("models/props_wasteland/rockcliff_cluster01b.mdl",Vector(-10820.4,-3191.8,860.1),Angle(-4.4,-142.7,-21.2))
	HL2C_Server:CreateProp("models/props_wasteland/rockcliff_cluster02a.mdl",Vector(-10467.8,-2926.1,940.2),Angle(25.2,-42.0,3.5))

	HL2C_Server:CreateTrigger(Vector(-7951.1,-8765.6,896.0),Vector(-7804.3,-8544.6,987.2), function(ent) 
		if not ent:IsPlayer() or not ent:Alive() or not IsHuman(ent) then return false end
		HL2C_Server:SetVehicle(VEHC_JEEP)
		return true
	end,true)

end

