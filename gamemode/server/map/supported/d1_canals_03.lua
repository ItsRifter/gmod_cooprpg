HL2C_Map.Weapons = {"weapon_crowbar","weapon_pistol"}
HL2C_Map.Loadout = {armour = 20,Pistol = 18}
HL2C_Map.Flags = {}
HL2C_Map.NextMap = "d1_canals_05"

HL2C_Map.Checkpoints = {
	{ min=Vector(-1488.0,672.7,-911.7),max=Vector(-1677.5,944.0,-954.5),spawn=Vector(-1588.6,850.4,-921.4),angle=Angle(4.8,-91.6,0.0), dist = 1024 },
	{ min=Vector(-416.0,-596.0,-939.7),max=Vector(-314.6,-392.6,-1018.0),spawn=Vector(-364.2,-488.9,-939.0),angle=Angle(38.9,-161.5,0.0), dist = 1024 },
	{ min=Vector(-1968.0,-577.5,-1090.3),max=Vector(-2832.0,-1166.4,-1131.0),spawn=Vector(-2091.9,-884.7,-1215.4),angle=Angle(3.8,170.9,0.0), dist = 1024 },
}

HL2C_Map.Warps = {

}

HL2C_Map.Spawn = { spawn=Vector(658.0,3293.2,-848.0),angle=Angle(4.2,-139.7,0.0)}

HL2C_Map.Exit = { min=Vector(-3535.1,-127.5,-1072.0),max=Vector(-3451.2,-39.1,-951.2)}

HL2C_Map.VortexChance = 25	--defaults if not set
HL2C_Map.VortexList = {Vector(-1462.2,1366.2,-822.7),Vector(-2323.5,798.5,-1016.7),Vector(-824.5,741.7,-1009.3),Vector(-3356.2,-824.0,-940.2)}

HL2C_Map.MapStartup = function()
	--HL2C_Map:RemoveMapEnts({1440,1441,1444,1621,1622,1623,1496})	
	
	--HL2C_Server:CreateProp("models/props_wasteland/cargo_container01.mdl",Vector(170,-120,-708),Angle(0,0,0))

	HL2C_Server:CreateTrigger(Vector(-2871,80,-1070),Vector(-2436,70,-1166), function(ent)	--Tired of people not able to climb out here at the end
		if ent:GetClass() == "func_physbox" then
			if ent:GetPhysicsObject():IsMotionEnabled() then 
				ent:GetPhysicsObject():EnableMotion( false )
				return true 
			end
		end
		return false
	end,
	0.5, false)

	--HL2C_Map:FireEnts("underground_portal_slippery02","open")
end