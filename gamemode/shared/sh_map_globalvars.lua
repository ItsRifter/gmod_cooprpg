//HL2C_SH_ = false

//NOT NEEDED FOR NOW

//Should pets be disabled?
///HL2C_SV_PETS_OFF = false

///Are non-vanilla weapons allowed?
///HL2C_SV_CUSTOMWEPS_OFF = false

HL2C_Global.PLY_NO_SUIT = HL2C_Global.PLY_NO_SUIT or false

if SERVER then
    --Are vortigaunts hostile to players?
   HL2C_Global.NPC_VORTENEMY = HL2C_Global.NPC_VORTENEMY or false

    --Are antlions friendly to players?
    HL2C_Global.NPC_ANTFRIEND = HL2C_Global.NPC_ANTFRIEND or false

    --Should players move slower even with sprint?
    HL2C_Global.PLY_REDUCEMOVE = HL2C_Global.PLY_REDUCEMOVE or false
	
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
	
	function HL2C_Global:SendGVs(ply)
		HL2C_Global:SendNoSuit(ply)
	end
	
	hook.Add("PlayerInitialSpawn", "HL2C_Sync_gvs", function(ply)
		HL2C_Global:SendGVs(ply)
	end)
	
end

function HL2C_Global:NoSuit()
	return HL2C_Global.PLY_NO_SUIT or false
end

if CLIENT then
    net.Receive("HL2C_GV_NOSUIT", function()
        HL2C_Global.PLY_NO_SUIT = net.ReadBool()
    end)
end