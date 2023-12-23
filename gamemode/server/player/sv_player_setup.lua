local hl2c_player = FindMetaTable("Player")

function hl2c_player:DoSpawn()
    local plyModel = string.format("models/player/Group01/male_0%s.mdl", tostring(math.random(1, 7)))
    self:SetModel(plyModel)

    self:SetTeam(TEAM_HUMAN)
    self:SetNoCollideWithTeammates(true)
end

hook.Add("PlayerSpawn", "HL2C_Player_Spawn", function(ply, transition)
    ply:DoSpawn()
end)