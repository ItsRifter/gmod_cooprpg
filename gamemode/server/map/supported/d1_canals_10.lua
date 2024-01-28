HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol","weapon_smg1","weapon_357","weapon_frag"}
HL2C_Map.Loadout = {armour = 40, Pistol = 27, SMG1 = 45, A357 = 6, Grenade = 2}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_11"

local function Ambush()	--spawn some extra npcs in to fill empty section
	HL2C_Server:CreateEnemy("npc_metropolice",Vector(4626.7,8994.5,-132.0),Angle(0,5,0),"weapon_smg1")
	HL2C_Server:CreateEnemy("npc_metropolice",Vector(4431.7,9108.7,-128.0),Angle(0,5,0),"weapon_smg1")
	HL2C_Server:CreateEnemy("npc_metropolice",Vector(4263.2,9622.6,-128.0),Angle(0,65,0),"weapon_pistol")
end

HL2C_Map.Checkpoints = {
	{ min=Vector(7579.1,5554.1,-584.6),max=Vector(8767.8,5621.7,-64.0),spawn=Vector(8693.3,5431.6,-351.5),angle=Angle(-0.8,109.7,0.0), dist = 4096, func = function() Ambush() end },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(11879.4,-12192.4,-507.3),angle=Angle(1.8,109.7,0.0)}

--HL2C_Map.Exit = { min=Vector(-1344.0,-7968.5,-427.0),max=Vector(-1856.0,-7821.0,-174.4), func = nil }

--HL2C_Map.VortexChance = 30	--defaults if not set
HL2C_Map.VortexList = {Vector(5385.1,-6787.1,-236.2),Vector(3878.7,9185.3,-235.8),Vector(11622.9,119.2,-365.7)}

HL2C_Map.MapStartup = function()
	HL2C_Server:SetVehicle(VEHC_AIRBOAT)

	HL2C_Server:CreateProp("models/props_canal/canal_bars001.mdl",Vector(4971.7,9531.7,-400.0),Angle(-0.0,-0.1,0.0))
	HL2C_Server:CreateProp("models/props_canal/canal_bars001.mdl",Vector(4969.4,9914.8,-400.0),Angle(0.0,0.5,0.0))
	HL2C_Server:CreateProp("models/props_junk/trashdumpster01a.mdl",Vector(4541.9,9325.4,-102.3),Angle(-0.0,-89.9,-0.0))
	
	--HL2C_Map:RemoveMapEnts({1825})	
	
	--HL2C_Map:RemoveMapEnts({1397,1398,1399,1400})	
	--HL2C_Map:FireEnts("areaportal_1","open")
end