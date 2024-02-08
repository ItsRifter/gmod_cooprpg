------------------------------------------------------------------
------------------------------------------------------------------

function HL2C_Server:CheckpointTriggered(cp, ply)
	if HL2C_Global:MapFailed() then return true end
	HL2C_Server:MoveSpawn(cp.TPPoint, cp.TPAngles, nil)
		
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, ply:Nick(), HL2R_TEXT_NORMAL, "##Game_Checkpoint")
		
	if cp.lambda and cp.lambda:IsValid() then cp.lambda:Remove() end
	if cp.Func then cp:Func() end

	for i, pl in ipairs( HL2C_Global:GetHumans() ) do
		if pl == ply then continue end
		--if IsHuman(pl) then
			if pl:GetNWBool("HL2C_Player_MapFin") then continue end
			
			if not pl:Alive() then
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
		--end
	end

end

function HL2C_Server:EndTriggered(cp, ply)
	if HL2C_Global:MapFailed() then return true end

	ply:SetNWBool("HL2C_Player_MapFin", true)
	ply:RemoveVehicle()
	ply:ToggleSpectator(true)
	ply:SpectateEntity(HL2C_Server.LvlExit.lambda)
	ply:EmitSound("vo/k_lab/kl_excellent.wav", 100, 100)
	
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, ply:Nick(), HL2R_TEXT_NORMAL, 
		"##GM_PlyFinished", HL2R_TEXT_ORANGE, string.FormattedTime(CurTime(), "%02i:%02i"))
	
	if cp.Func then cp:Func(ply) end
	cp.Triggered = true
	
	HL2C_Server:CheckFinished()
end

------------------------------------------------------------------
------------------------------------------------------------------

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

function HL2C_Server:IsExtended()
	if game.GetGlobalState("hl2c_extended") == GLOBAL_ON then
		return true
	end

	return false
end

function HL2C_Server:SetExtended(value)
	game.SetGlobalState("hl2c_extended", value)
end

function HL2C_Server:SpawnItem(mdl,pos)
    local prop = ents.Create("prop_physics")
    prop:SetModel(mdl)
    prop:SetPos(pos)
    prop:Spawn()
end

------------------------------------------------------------------
------------------------------------------------------------------

local T_END_NAME = "TIMER_LVLCHANGE"
local T_END_TIME = 60	--We can afford to have more time now the fast end is working
local T_END_FAST = 8
local T_END_FAILED = 12

HL2C_Server.EndTime = HL2C_Server.EndTime or 0

function HL2C_Server:MapFailed()
	if HL2C_Global:MapWon() or HL2C_Global:MapFailed() then return false end

	HL2C_Global:SetMapFailed(true)

	timer.Create(T_END_NAME, T_END_FAILED, 1, function() HL2C_Server:RestartLevel() end)
	
	HL2C_Server.EndTime = CurTime() + T_END_FAILED
	HL2C_Server:SendCountdown()
end

function HL2C_Server:CheckFinished()
	local total = 0
	local finished = 0

	for i, ply in ipairs( player.GetAll() ) do
		if IsHuman(ply) then
			total = total + 1
			if ply:GetNWBool("HL2C_Player_MapFin") then
				finished = finished + 1
			end
		end
	end
	
	if finished > 0 then
		HL2C_Global:SetMapWon(true)
	end
	
	self:DebugMsg(string.format("%i / %i players finished the map", finished, total))

	if total == 0 then
		HL2C_Server:CountDown(false,true)
		return
	end

	local ratio = 1 / total * finished
	
	if ratio > 0.9 then
		HL2C_Server:CountDown(true, true)
	elseif ratio >0.4 then
		HL2C_Server:CountDown(true, false)
	end
end

function HL2C_Server:SendCountdown(ply)
	net.Start( "HL2C_Countdown" )
		net.WriteFloat( HL2C_Server.EndTime )
	if not ply then net.Broadcast() else net.Send(ply) end
end

hook.Add("PlayerInitialSpawn", "HL2C_Sync_countdown", function(ply)
	HL2C_Server:SendCountdown(ply)
end)

function HL2C_Server:CountDown(active,force)
	if timer.Exists(T_END_NAME) then 
		if force then
			if active then
				if timer.TimeLeft( T_END_NAME ) > T_END_FAST then
					timer.Remove(T_END_NAME)
					timer.Create(T_END_NAME, T_END_FAST, 1, function() HL2C_Server:ChangeLevel() end)
					
					HL2C_Server.EndTime = CurTime() + T_END_FAST
					HL2C_Server:SendCountdown()
					
					---net.Start( "HL2C_Countdown" )
					---	net.WriteFloat( CurTime() + T_END_FAST)
					---net.Broadcast()
				end
			else
				timer.Remove(T_END_NAME)
				HL2C_Server.EndTime = 0
				HL2C_Server:SendCountdown()
				--net.Start( "HL2C_Countdown" )
				--	net.WriteFloat( 0)
				--net.Broadcast()
			end
		end
	else
		if not active then return end

		if force then
			timer.Create(T_END_NAME, T_END_FAST, 1, function() HL2C_Server:ChangeLevel() end)
			
			HL2C_Server.EndTime = CurTime() + T_END_FAST
			HL2C_Server:SendCountdown()
			
			--net.Start( "HL2C_Countdown" )
			--	net.WriteFloat( CurTime() + T_END_FAST)
			--net.Broadcast()
		else
			timer.Create(T_END_NAME, T_END_TIME, 1, function() HL2C_Server:ChangeLevel() end)
			
			HL2C_Server.EndTime = CurTime() + T_END_TIME
			HL2C_Server:SendCountdown()
			--net.Start( "HL2C_Countdown" )
			--	net.WriteFloat( CurTime() + T_END_TIME)
			--net.Broadcast()
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

function HL2C_Server:RestartLevel()
	timer.Simple(1 , function()  RunConsoleCommand( "changelevel", game.GetMap() )  end)
end

------------------------------------------------------------------
------------------------------------------------------------------

local VortexList = VortexList or {}
function HL2C_Server:VortexTouched(ply)
	if not table.HasValue( VortexList, ply) then
		if table.IsEmpty( VortexList ) then 
			HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE,ply:Nick(),HL2R_TEXT_NORMAL,"##Game_Vortex") 
			ply:AddExp(120)
		else
			ply:AddExp(60)
		end
		
		table.insert( VortexList, ply)
		ply:EmitSound("ambient/levels/prison/radio_random11.wav")
	end
end