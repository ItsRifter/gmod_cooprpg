HL2C_Server.Cps = HL2C_Server.Cps or {}

function HL2C_Server:CreateCP(Min,Max,TPos,TAngle,func)
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