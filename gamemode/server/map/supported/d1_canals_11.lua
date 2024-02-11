HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 27, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_12"


HL2C_Map.Checkpoints = {
	{ min=Vector(6387.3,5211.7,-713.0),max=Vector(6464.2,4591.4,-1022.1),spawn=Vector(6436.2,4989.4,-954.0),angle=Angle(-3.1,165.9,0.0), func = function() HL2C_Server:SetVehicle(VEHC_NONE) end, dist = 1024},
	{ min=Vector(5640.1,4476.4,-1005.1),max=Vector(5506.4,5156.5,-803.4),spawn=Vector(5742.4,4805.8,-939.3),angle=Angle(3.5,174.0,0.0), func = function() HL2C_Server:SetVehicle(VEHC_AIRBOAT_GUN) end },
	
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(10050.3,8771.4,-930.2),angle=Angle(-0.8,-94.5,0.0)}

HL2C_Map.Exit = { min=Vector(-11332.6,-379.3,-1125.5),max=Vector(-11733.7,-166.0,-822.8), func = function(cp,ply)
	ply:UpdateAchievementProgress("HL2_Canals", 11)
end }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(5911.3,5350.7,-878.5),Vector(10221.3,7629.7,-508.5),Vector(8487.9,5986.2,-877.7),Vector(4980.0,-4095.5,-910.2),Vector(-11915.4,-1742.0,-844.0)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT)

	--HL2C_Map:RemoveMapEnts({1825})	
	
	HL2C_Map:RemoveMapEnts({1879,1880,1881,1882})	
	HL2C_Map:FireEnts("portal_guncave_exit","open")
	HL2C_Map:FireEnts("portal_guncave_exit2","open")

	ents.FindByName("gate1")[1]:GetPhysicsObject():EnableGravity( false )	--Makes gate fail to drop so dont need checkpoint
	
	ents.FindByName("lcs_gc_briefing1_post")[1]:Fire("AddOutput", "OnCompletion lcs_guncave_goodbye1:start:1:-1")
end