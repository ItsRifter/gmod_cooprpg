local hl2c_player = FindMetaTable("Player")

function hl2c_player:DoSpawn()
    if self:Team() == TEAM_UNASSIGNED then 
        self:SetTeam(TEAM_HUMAN)
        self:SetNWBool("HL2C_Player_MapFin", false)
    end
    
    local plyModel = string.format("models/player/Group01/male_0%s.mdl", tostring(math.random(1, 7)))
    self:SetModel(plyModel)

	self:SetupSuit()
	
    self:SetNoCollideWithTeammates(true)
    self:GiveWeapons()
	self:GiveLoadout()

    
end

hook.Add("PlayerSpawn", "HL2C_Player_Spawn", function(ply, transition)
    ply:DoSpawn()
end)

--Called right after GM:DoPlayerDeath, GM:PlayerDeath and GM:PlayerSilentDeath.
function hl2c_player:PostDeath()
    if self:FlashlightIsOn() then self:Flashlight( false ) end
end

hook.Add("PostPlayerDeath", "HL2C_Player_PostDeath", function(ply, transition)
    ply:PostDeath()
end)

function HandlePVP(ply, att)

    if ply:Team() == att:Team() then return true end

    return false
end

hook.Add("EntityTakeDamage", "HL2C_CheckPVP", function(ent, dmgInfo)
    if ent:IsPlayer() then

        local att = dmgInfo:GetAttacker()

        if att:IsPlayer() and att ~= ent then
            return HandlePVP(ent, att)
        end
    end

    return false
end)