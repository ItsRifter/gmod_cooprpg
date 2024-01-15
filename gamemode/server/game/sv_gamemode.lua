
function HL2C_Server:CheckpointTriggered(cp, ply)
	HL2C_Server:MoveSpawn(cp.TPPoint, cp.TPAngles, nil)
		
	if cp.lambda and cp.lambda:IsValid() then cp.lambda:Remove() end

	if cp.Func then cp:Func() end

	for i, pl in ipairs( player.GetAll() ) do
		if pl == ply then continue end
		if IsHuman(pl) then
			if pl:IsTeam(TEAM_HUMAN_FIN) then continue end
			
			if pl:IsTeam(TEAM_HUMAN_DEAD) then
				pl:Spawn()
				pl:SetPos(cp.TPPoint)
				pl:SetEyeAngles(cp.TPAngles)
				pl:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
			else
				local warp = true
				if cp.Dist then
					local range = cp.TPPoint:DistToSqr( pl:GetPos() )
					if range < cp.Dist then warp = false end
				end
				if warp then
					pl:SetPos(cp.TPPoint)
					pl:SetEyeAngles(cp.TPAngles)
					pl:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
				end
			end
			
		end
	end

end

function HL2C_Server:EndTriggered(cp,ply)
	ply:SetTeam(TEAM_HUMAN_FIN)
	ply:EmitSound("vo/k_lab/kl_excellent.wav", 100, 100)
	
	if cp.Func then cp:Func(ply) end
	cp.Triggered = true
	
	HL2C_Server:CheckFinished()
end

function HL2C_Server:EndProp(ent)
	if HL2C_Map.ExitModel then 
		if HL2C_Map.ExitModel(ent) then
			ent:EmitSound("hl2cr/standardbeep.wav", 100, 100)
			ent:Remove()
		end
	end
end

function HL2C_Server:BringItem()
	if game.GetGlobalState("hl2c_bringitem") == GLOBAL_ON then
		game.SetGlobalState("hl2c_bringitem", GLOBAL_DEAD)
		return true
	end
	return false
end

function HL2C_Server:SpawnItem(mdl,pos)
    local prop = ents.Create("prop_physics")
    prop:SetModel(mdl)
    prop:SetPos(pos)
    prop:Spawn()
end

function HL2C_Server:CheckFinished()
	local total = 0
	local finished = 0
	for i, ply in ipairs( player.GetAll() ) do
		if IsHuman(ply) then
			total = total + 1
			if ply:IsTeam(TEAM_HUMAN_FIN) then
				finished = finished+ 1
			end
		end
	end
	print(finished.."/"..total.." players finished the level")
	if total == 0 then
		HL2C_Server:CountDown(false,true)
		return
	end
	local ratio = 1/total*finished
		
	if ratio > 0.9 then
		HL2C_Server:CountDown(true,true)
	elseif ratio >0.4 then
		HL2C_Server:CountDown(true,false)
	end
	
end

local T_END_NAME = "TIMER_LVLCHANGE"
local T_END_TIME = 40
local T_END_FAST = 6

function HL2C_Server:CountDown(active,force)
	if timer.Exists(T_END_NAME) then 
		if force then
			if active then
				if timer.TimeLeft( T_END_NAME ) > T_END_FAST then
					timer.Remove(T_END_NAME)
					timer.Create(T_END_NAME, T_END_FAST, 1, function() HL2C_Server:ChangeLevel() end)
					
					net.Start( "HL2C_Countdown" )
						net.WriteFloat( CurTime() + T_END_FAST)
					net.Broadcast()
				end
			else
				timer.Remove(T_END_NAME)
				net.Start( "HL2C_Countdown" )
					net.WriteFloat( 0)
				net.Broadcast()
			end
		end
	else
		if not active then return end
		if force then
			timer.Create(T_END_NAME, T_END_FAST, 1, function() HL2C_Server:ChangeLevel() end)
			
			net.Start( "HL2C_Countdown" )
				net.WriteFloat( CurTime() + T_END_FAST)
			net.Broadcast()
		else
			timer.Create(T_END_NAME, T_END_TIME, 1, function() HL2C_Server:ChangeLevel() end)
			net.Start( "HL2C_Countdown" )
				net.WriteFloat( CurTime() + T_END_TIME)
			net.Broadcast()
		end
	end
end

local LOBBY_MAP = "hl2cr_lobby_v2"
function HL2C_Server:ChangeLevel()
	if HL2C_Map.NextMap then
		timer.Simple(1 , function()  RunConsoleCommand( "changelevel", HL2C_Map.NextMap )  end)
	else
		timer.Simple(1 , function()  RunConsoleCommand( "changelevel", LOBBY_MAP )  end)
	end
	
end