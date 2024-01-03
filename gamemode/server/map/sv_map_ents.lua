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
	
	table.insert( HL2C_Server.Cps, cp )
	
	--if func then
	--	cp.Func = func
	--end
	
	--checkpoint.lambdaModel = ents.Create("prop_dynamic")
	--checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
	--checkpoint.lambdaModel:SetPos( checkpoint.TPPoint + Vector(0, 0, 75))
	--checkpoint.lambdaModel:Spawn()
	--checkpoint.lambdaModel:ResetSequence("idle")
	--checkpoint.lambdaModel:SetMaterial(checkpoint.Mat)
end

function HL2C_Server:RemoveCPs()
	for k, v in pairs( HL2C_Server.Cps ) do
		v:Remove()
	end
	HL2C_Server.Cps = {}
end

function HL2C_Server:MoveSpawn(TPPoint,TPAngles, parent)
	print("moving spawn")
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
	
	if HL2C_Map.Spawn then HL2C_Server:MoveSpawn(HL2C_Map.Spawn.spawn,HL2C_Map.Spawn.angle) end
	
	if HL2C_Map.Checkpoints then
		for k, cpdata in pairs( HL2C_Map.Checkpoints ) do
			HL2C_Server:CreateCP(cpdata.min,cpdata.max,cpdata.spawn,cpdata.angle,cpdata.func or nil, cpdata.dist or nil)
		end
	end
	
	if HL2C_Map.MapStartup then HL2C_Map.MapStartup() end
end