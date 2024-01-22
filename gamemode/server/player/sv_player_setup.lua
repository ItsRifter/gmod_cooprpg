local hl2c_player = FindMetaTable("Player")

function hl2c_player:DoSpawn()
    local plyModel = string.format("models/player/Group01/male_0%s.mdl", tostring(math.random(1, 7)))
    self:SetModel(plyModel)

	

    if self:IsTeam(TEAM_HUMAN_DEAD) or self:IsTeam(TEAM_UNASSIGNED) then self:SetTeam(TEAM_HUMAN_ALIVE) end
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
	if self:IsTeam(TEAM_HUMAN_ALIVE) then self:SetTeam(TEAM_HUMAN_DEAD) end
	if self:FlashlightIsOn() then self:Flashlight( false ) end
end

hook.Add("PostPlayerDeath", "HL2C_Player_PostDeath", function(ply, transition)
    ply:PostDeath()
end)