HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag","weapon_physcannon","weapon_shotgun"}
HL2C_Map.Loadout = {armour = 40, Pistol = 64, SMG1 = 60, A357 = 6, Grenade = 1, Buckshot = 12}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_04"


HL2C_Map.Spawn = { spawn=Vector(-5077.4,2121.8,-3247.9),angle=Angle(0.7,158.3,0.0)}

HL2C_Map.Exit = { min=Vector(-6528.0,-747.1,-3264.0),max=Vector(-6638.9,-679.2,-3096.0), func = nil }

HL2C_Map.Checkpoints = {
	{ min=Vector(-6939.1,1052.0,-3354.2),max=Vector(-7427.7,380.3,-3408.0),spawn=Vector(-7047.5,990.7,-3407.7),angle=Angle(3.5,-141.6,0.0), dist = 1024 },
	{ min=Vector(-7523.7,-153.2,-3408.0),max=Vector(-7476.9,-531.5,-3245.0),spawn=Vector(-7501.3,-264.3,-3408.0),angle=Angle(-5.2,-13.6,0.0), func = nil },
}

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-6749.8,727.5,-3245.1)}

HL2C_Map.MapStartup = function()

	--local monk = ents.Create("npc_monk")	--Not needed anymore but might want to turn into a function
	--monk:SetPos(Vector(-5236.1,2026.3,-3246.9))
	--monk:SetAngles(Angle(0,90,0))
	--monk:Give( "weapon_annabelle" )
	--monk:Fire( "addoutput", "targetname monk" );
	--monk:Spawn()

	HL2C_Server:SetExtended(GLOBAL_DEAD)

	if HL2C_Server:BringItem() then
		HL2C_Server:SpawnItem("models/roller.mdl",Vector(-5262.8,2328.7,-3282.7))
	end
	
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
		game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end