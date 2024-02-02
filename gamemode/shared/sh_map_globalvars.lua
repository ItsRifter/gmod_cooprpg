//HL2C_SH_ = false

//NOT NEEDED FOR NOW

//Should pets be disabled?
///HL2C_SV_PETS_OFF = false

///Are non-vanilla weapons allowed?
///HL2C_SV_CUSTOMWEPS_OFF = false

if SERVER then
    //Are vortigaunts hostile to players?
    HL2C_SV_NPC_VORTENEMY = HL2C_SV_NPC_VORTENEMY or false

    //Are antlions friendly to players?
    HL2C_SV_NPC_ANTFRIEND = HL2C_SV_NPC_ANTFRIEND or false

    //Should players move slower even with sprint?
    HL2C_SV_PLY_REDUCEMOVE = false
end

if CLIENT then
    HL2C_CL_HUD_OFF = HL2C_CL_HUD_OFF or false

    net.Receive("HL2C_HUD_Toggle", function()
        HL2C_CL_HUD_OFF = net.ReadBool()
    end)
end