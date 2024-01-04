local hl2c_player = FindMetaTable("Player")

function hl2c_player:DoSpawn()
    local plyModel = string.format("models/player/Group01/male_0%s.mdl", tostring(math.random(1, 7)))
    self:SetModel(plyModel)

	local teamnum = self:Team()

    if teamnum == TEAM_HUMAN_DEAD or teamnum == TEAM_UNASSIGNED then self:SetTeam(TEAM_HUMAN_ALIVE) end
	
    self:SetNoCollideWithTeammates(true)
    self:GiveWeapons()
end

hook.Add("PlayerSpawn", "HL2C_Player_Spawn", function(ply, transition)
    ply:DoSpawn()
end)


--Called right after GM:DoPlayerDeath, GM:PlayerDeath and GM:PlayerSilentDeath.
function hl2c_player:PostDeath( ply )
	if ply:Team() == TEAM_HUMAN_ALIVE then ply:SetTeam(TEAM_HUMAN_DEAD) end
end

hook.Add("PostPlayerDeath", "HL2C_Player_PostDeath", function(ply, transition)
    ply:PostDeath()
end)