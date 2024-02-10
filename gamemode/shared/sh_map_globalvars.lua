//NOT NEEDED FOR NOW

//Should pets be disabled?
///HL2C_SV_PETS_OFF = false

///Are non-vanilla weapons allowed?
///HL2C_SV_CUSTOMWEPS_OFF = false

HL2C_Global.PLY_NO_SUIT = HL2C_Global.PLY_NO_SUIT or false
HL2C_Global.MAP_FAILED = HL2C_Global.MAP_FAILED or false
HL2C_Global.MAP_VORTEX = HL2C_Global.MAP_VORTEX or false

if SERVER then
    --Are vortigaunts hostile to players?
   HL2C_Global.NPC_VORTENEMY = HL2C_Global.NPC_VORTENEMY or false

    --Are antlions friendly to players?
    HL2C_Global.NPC_ANTFRIEND = HL2C_Global.NPC_ANTFRIEND or false

    --Should players move slower even with sprint?
    HL2C_Global.PLY_REDUCEMOVE = HL2C_Global.PLY_REDUCEMOVE or false
	
	-------------------------------------------------------------------
	-------------------------------------------------------------------
	
	function HL2C_Global:SetNoSuit(nosuit)
		if nosuit == HL2C_Global:NoSuit() then return end
		HL2C_Global.PLY_NO_SUIT = nosuit
		HL2C_Global:SendNoSuit()
	end
	
	function HL2C_Global:SendNoSuit(ply)
		net.Start( "HL2C_GV_NOSUIT" )
			net.WriteBool( HL2C_Global.PLY_NO_SUIT )
		if not ply then net.Broadcast() else net.Send(ply) end
	end
	
	-------------------------------------------------------------------
	
	function HL2C_Global:SetMapFailed(failed)
		if failed == HL2C_Global:MapFailed() then return end
		HL2C_Global.MAP_FAILED = failed
		HL2C_Global:SendMapFailed()
	end

	function HL2C_Global:SendMapFailed(ply)
		net.Start( "HL2C_GV_MAPFAILED" )
			net.WriteBool( HL2C_Global.MAP_FAILED )
		if not ply then net.Broadcast() else net.Send(ply) end
	end
	
	-------------------------------------------------------------------
	
	function HL2C_Global:SetMapWon(won)
		if won == HL2C_Global:MapWon() then return end
		HL2C_Global.MAP_WON = won
		HL2C_Global:SendMapWon()
	end

	function HL2C_Global:SendMapWon(ply)
		net.Start( "HL2C_GV_MAPWON" )
			net.WriteBool( HL2C_Global.MAP_WON )
		if not ply then net.Broadcast() else net.Send(ply) end
	end
	
	-------------------------------------------------------------------
	
	function HL2C_Global:SetVortex(vortex)
		if vortex == HL2C_Global:NoSuit() then return end
		HL2C_Global.MAP_VORTEX = vortex
		HL2C_Global:SendVortex()
	end
		
	function HL2C_Global:SendVortex(ply)
		net.Start( "HL2C_GV_VORTEX" )
			net.WriteBool( HL2C_Global.MAP_VORTEX )
		if not ply then net.Broadcast() else net.Send(ply) end
	end
	
	-------------------------------------------------------------------
	-------------------------------------------------------------------
	
	function HL2C_Global:SendGVs(ply)
		HL2C_Global:SendNoSuit(ply)
		HL2C_Global:SendMapFailed(ply)
		HL2C_Global:SendMapWon(ply)
		HL2C_Global:SendVortex(ply)
	end
	
	hook.Add("PlayerInitialSpawn", "HL2C_Sync_gvs", function(ply)
		HL2C_Global:SendGVs(ply)
	end)
	
end

function HL2C_Global:NoSuit()
	return HL2C_Global.PLY_NO_SUIT or false
end

function HL2C_Global:MapFailed()
	return HL2C_Global.MAP_FAILED or false
end

function HL2C_Global:MapWon()
	return HL2C_Global.MAP_WON or false
end

function HL2C_Global:MapVortex()
	return HL2C_Global.MAP_VORTEX or false
end

if CLIENT then
    net.Receive("HL2C_GV_NOSUIT", function()
        HL2C_Global.PLY_NO_SUIT = net.ReadBool()
    end)
	
    net.Receive("HL2C_GV_MAPFAILED", function()
        HL2C_Global.MAP_FAILED = net.ReadBool()
		if HL2C_Global:MapFailed() then	--We can save having to send command to play sound to players this way
			surface.PlaySound( "music/hl2_song23_suitsong3.mp3" )
		end
    end)
	
    net.Receive("HL2C_GV_VORTEX", function()
        HL2C_Global.MAP_VORTEX = net.ReadBool()
    end)
end