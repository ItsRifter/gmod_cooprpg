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
	cp.Dist = nil
	if dist then cp.Dist = dist * dist end
	
	cp.lambda = HL2C_Server:CreateLambdaIcon(cp.TPPoint+ Vector(0, 0, 75),"hl2c/x64")
	--cp.lambda = HL2C_Server:CreateLambdaIcon(cp.TPPoint+ Vector(0, 0, 75),"models/props_combine/tprings_globe")
	cp.lambda:SetColor4Part(255, 100, 0, 120)
	cp.lambda:SetRenderFX( 3 )

	table.insert( HL2C_Server.Cps, cp )
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
	
	LvlExit.lambda = HL2C_Server:CreateLambdaIcon(LvlExit.Pos,"hl2c/x64")
	LvlExit.lambda:SetColor4Part(50, 200, 50, 120)
	LvlExit.lambda:SetRenderFX( 3 )
	
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
	HL2C_Server:RemoveChangeLevel()
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

function HL2C_Server:RemoveChangeLevel()
    for _, c in pairs(ents.FindByClass("trigger_changelevel")) do
        c:Remove()
    end
end

function HL2C_Server:CreateLambdaIcon(pos,mat)
	--local lambda = ents.Create("prop_dynamic")
	local lambda = ents.Create("hl2c_lambda")
	--lambda:SetModel("models/hl2cr_lambda.mdl")
	--lambda:SetModel("models/hl2c/lamba_logo.mdl")
	lambda:SetPos( pos)
	lambda:SetAngles(Angle(0,0,0))
	lambda:Spawn()
	--lambda:ResetSequence("idle")

	--lambda:SetMaterial(mat)
	return lambda
end