HL2C_Map.Weapons = {}
HL2C_Map.Loadout = {}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_trainstation_02"

HL2C_Map.Spawn = { spawn=Vector(-14576.0,-14208.0,-1300.0),angle=Angle(0.0,90.0,0.0)}

HL2C_Map.Exit = { min=Vector(-3137.7,-617.4,192.0),max=Vector(-3200.0,-514.1,25.2), func = nil }

HL2C_Map.VortexChance = 15
HL2C_Map.VortexList = {Vector(-5289.2,-1010.7,100.8)}


local function FixFOV()
	for _, v in ipairs(player.GetAll()) do
		v:SetFOV(0, 1)
	end
end

HL2C_Map.Checkpoints = {
	{ min=Vector(-9508.6,-2781.9,-64.0),max=Vector(-8959.9,-2049.8,177.6),spawn=Vector(-9378.7,-2466.6,34),angle=Angle(0.9,16.0,0.0)},
	{ min=Vector(-5512.7,-1931.3,-32.0),max=Vector(-5167.0,-2128.1,126.5),spawn=Vector(-5370.9,-1964.5,16.0),angle=Angle(7.3,-2.3,0.0),func = function() FixFOV() end, dist = 256 },
	{ min=Vector(-3612.7,-390.2,-32.0),max=Vector(-3264.0,-266.3,95.4),spawn=Vector(-3578.6,-350.6,-22.7),angle=Angle(2.2,3.8,0.0) },
}

HL2C_Map.MapStartup = function()
	HL2C_Global:SetNoSuit(true)
	game.SetGlobalState("gordon_precriminal", 1)	--temp needed?

	HL2C_Map:RemoveMapEnts({1596,1981})	--remove a few door closing triggers
end
