HL2C_Server.Cps = HL2C_Server.Cps or {}

function HL2C_Server:CreateCP(Min,Max,TPos,TAngle,func,dist)
	local cp = ents.Create("trigger_hl2c_cp")
	cp.Min = Min
	cp.Max = Max
	cp.Pos = (Max + Min)/2
	cp.TPPoint = TPos
	cp.TPAngles = TAngle or cp.TPAngles
	--checkpoint.PointIndex = 99
	cp:SetPos(cp.Pos)
	cp:Spawn()
	
	cp.Func = func or nil
	
	table.insert( HL2C_Server.Cps, cp )
	
	--checkpoint.lambdaModel = ents.Create("prop_dynamic")
	--checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
	--checkpoint.lambdaModel:SetPos( checkpoint.TPPoint + Vector(0, 0, 75))
	--checkpoint.lambdaModel:Spawn()
	--checkpoint.lambdaModel:ResetSequence("idle")
	--checkpoint.lambdaModel:SetMaterial(checkpoint.Mat)
end

function HL2C_Server:RemoveCPs()
	for k, v in pairs( HL2C_Server.Cps ) do
		if IsValid(v) then v:Remove() end
	end
	
	HL2C_Server.Cps = {}
end

HL2C_Server.LvlExit = HL2C_Server.LvlExit or nil

function HL2C_Server:SpawnExit(Min,Max,func)
	if HL2C_Server.LvlExit then 
		if IsValid(HL2C_Server.LvlExit) then HL2C_Server.LvlExit:Remove() end
	end
	
	local LvlExit = ents.Create("trigger_hl2c_endlvl")
	LvlExit.Min = Min
	LvlExit.Max = Max
	LvlExit.Pos = (Max + Min)/2
	LvlExit:SetPos(LvlExit.Pos)
	LvlExit:Spawn()
	
	LvlExit.Func = func or nil
	
	HL2C_Server.LvlExit = LvlExit
end

function HL2C_Server:MoveSpawn(TPPoint,TPAngles, parent)
	HL2C_Server:DebugMsg("Moving spawnpoint", -1)
	local NewPos = TPPoint
	if parent then 
		if isstring( parent) then
			parent = ents.FindByName(parent)[1]
		end
		NewPos = parent:GetPos() +NewPos 
	else
		parent = nil
	end

	for l, spawn in pairs(ents.FindByClass("info_player_start")) do
		spawn:Remove()
	end

	for l, spawn in pairs(ents.FindByClass("info_player_deathmatch")) do
		spawn:Remove()
	end
	
	local newspawn = ents.Create("info_player_start")
	newspawn:SetPos(NewPos)
	newspawn:SetAngles(TPAngles )
	newspawn:SetParent(parent)
	newspawn:Spawn()
end

function HL2C_Server:SetupMap()
	HL2C_Server:RemoveCPs()
	
	if HL2C_Map.Spawn then HL2C_Server:MoveSpawn(HL2C_Map.Spawn.spawn, HL2C_Map.Spawn.angle) end
	
	if HL2C_Map.Exit then HL2C_Server:SpawnExit(HL2C_Map.Exit.min, HL2C_Map.Exit.max, HL2C_Map.Exit.func or nil) end
	
	if HL2C_Map.Checkpoints then
		for k, cpdata in pairs( HL2C_Map.Checkpoints ) do
			HL2C_Server:CreateCP(cpdata.min,cpdata.max, cpdata.spawn, cpdata.angle, cpdata.func or nil, cpdata.dist or nil)
		end
	end
	
	if HL2C_Map.MapStartup then HL2C_Map.MapStartup() end
end