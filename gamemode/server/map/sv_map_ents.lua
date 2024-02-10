HL2C_Server.Cps = HL2C_Server.Cps or {}

function HL2C_Server:CreateCP(Min, Max, TPos, TAngle, func, dist)
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
	
	cp.lambda = HL2C_Server:CreateLambdaIcon(cp.TPPoint+ Vector(0, 0, 75), "hl2c/x64")
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

HL2C_Server.LvlExit = HL2C_Server.LvlExit or nil	--If exit needs to move for extended maps, saves reference to old on to remove it
function HL2C_Server:SpawnExit(Min,Max,func)
	if HL2C_Server.LvlExit then 
		if IsValid(HL2C_Server.LvlExit) then 
			if IsValid(HL2C_Server.LvlExit.lambda) then HL2C_Server.LvlExit.lambda:Remove()  end
			HL2C_Server.LvlExit:Remove() 
		end
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

function HL2C_Server:CreateTrigger(Min,Max,func,once,delay)
	local trig = ents.Create("trigger_hl2c_custom")
	trig.Min = Min
	trig.Max = Max
	trig.Pos = (Max + Min)/2

	trig:SetPos(trig.Pos)
	trig:Spawn()
	
	trig.Once = once or false
	trig.Delay = delay or 0
	
	trig.Func = func or nil
end

function HL2C_Server:CreateWarp(Min,Max,TPos,TAngle)
	local warp = ents.Create("trigger_hl2c_warp")
	warp.Min = Min
	warp.Max = Max
	warp.Pos = (Max + Min)/2
	warp.TPPoint = TPos
	warp.TPAngles = TAngle or warp.TPAngles
	--checkpoint.PointIndex = 99
	warp:SetPos(warp.Pos)
	warp:Spawn()
	
	return warp
end

function HL2C_Server:CreateInfoboard(Pos, Angle ,Width, Height,text)
	local display = ents.Create("hl2c_infoboard")

	local offset = Vector(Width*0.5,1,Height*0.5)
	display.OBBMax = Pos + offset;
	display.OBBMin = Pos - offset;

	display:SetNetworkedVector("OBB_Min", display.OBBMin)
	display:SetNetworkedVector("OBB_Max", display.OBBMax)
	display:SetNetworkedVector("Text", text)

	display:SetAngles(Angle)
	display:SetPos(Pos)
	display:Spawn()
end

function HL2C_Server:SetupMap()
	HL2C_Server:SetupWeapons()
	HL2C_Server:RemoveChangeLevel()
		
	timer.Simple( 0.25, function()  
		HL2C_Map:RemoveNewGameEnts() --WIP, I think this works decently now.
	end)
	
	HL2C_Server:RemoveCPs()
	
	if HL2C_Map.Spawn then HL2C_Server:MoveSpawn(HL2C_Map.Spawn.spawn, HL2C_Map.Spawn.angle) end
	if HL2C_Map.Exit then HL2C_Server:SpawnExit(HL2C_Map.Exit.min, HL2C_Map.Exit.max, HL2C_Map.Exit.func or nil) end
	
	if HL2C_Map.MapStartup then HL2C_Map.MapStartup() end
	
	if HL2C_Map.Checkpoints then
		for k, cpdata in pairs( HL2C_Map.Checkpoints ) do
			HL2C_Server:CreateCP(cpdata.min,cpdata.max, cpdata.spawn, cpdata.angle, cpdata.func or nil, cpdata.dist or nil)
		end
	end
	
	if HL2C_Map.Warps then
		for k, warpdata in pairs( HL2C_Map.Warps ) do
			HL2C_Server:CreateWarp(warpdata.min,warpdata.max, warpdata.spawn, warpdata.angle)
		end
	end
	
	if HL2C_Map.VortexList then
		local chance = HL2C_Map.VortexChance or 30
	
		if math.Rand( 0, 100 ) < chance then
			local pos = HL2C_Map.VortexList[ math.random( #HL2C_Map.VortexList ) ]
			HL2C_Server:CreateVortex(pos)
			HL2C_Global:SetVortex(true)
		else
			HL2C_Global:SetVortex(false)
		end
	end
end

function HL2C_Server:RemoveChangeLevel()
    for _, c in pairs(ents.FindByClass("trigger_changelevel")) do
        c:Remove()
    end
end

function HL2C_Server:CreateProp(mdl,pos,ang,hidden)
    local prop = ents.Create("prop_dynamic")
    prop:SetModel(mdl)
    prop:SetPos(pos)
	prop:SetAngles(ang)
	prop:PhysicsInit( 6 )
	prop:Spawn()
	
	if hidden then
		prop:SetRenderMode( RENDERMODE_ENVIROMENTAL ) --makes invisible
		prop:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		prop:DrawShadow( false )
	end
	
	return prop
end

function HL2C_Server:CreateLambdaIcon(pos,mat)
	local lambda = ents.Create("hl2c_lambda")
	lambda:SetPos(pos)
	lambda:Spawn()

	return lambda
end

function HL2C_Server:CreateVortex(pos)
	local vortex = ents.Create("hl2c_vortex")
	vortex:SetPos(pos)
	vortex:Spawn()

	--return
end