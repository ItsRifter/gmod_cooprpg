HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 36, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_town_01"

function GiveGravGun()
	HL2C_Server:AddWeaponRespawns("weapon_physcannon",nil,true)
	
	HL2C_Server:CreateCP( Vector(-694.9,954.9,-2688.0),Vector(-509.3,1026.4,-2591.2),Vector(-603.3,1031.5,-2688.0),Angle(3.3,85.3,0.0))
end

HL2C_Map.Checkpoints = {
	{ min=Vector(-784.0,816.6,-2565.0),max=Vector(-480.1,843.6,-2688.0),spawn=Vector(-699.1,720.5,-2688.0),angle=Angle(1.0,0.2,0.0)},
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(-579.0,978.9,-2688.0),angle=Angle(1.7,-97.6,0.0)}

HL2C_Map.Exit = { min=Vector(-3561.9,4080.0,-1663.0),max=Vector(-3678.1,4017.2,-1536.0) }

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-911.2,377.7,-2358.8),Vector(-2384.3,-390.9,-2668.5)}

HL2C_Map.MapStartup = function()
	ents.FindByName( "trigger_Get_physgun" )[1]:Fire("AddOutput", "OnTrigger hl2c_lua:RunPassedCode:GiveGravGun()" )

	HL2C_Map:RemoveNamedEnts("trigger_RavenDoor_Drop")
	
end

HL2C_Map.ExitModel = function(ent)
	if not (ent:GetModel() == "models/roller.mdl") then return false end
	game.SetGlobalState("hl2c_bringitem", GLOBAL_ON)
	return true
end