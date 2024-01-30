local hl2c_player = FindMetaTable("Player")

TEAM_CONNECTED = 0
team.SetUp(TEAM_CONNECTED,	"Connected", Color(255, 215, 140))

TEAM_AFK = 5
team.SetUp(TEAM_AFK,		"AFK", Color(255, 215, 140))

TEAM_SPEC = 9
team.SetUp(TEAM_SPEC,		"Observer", Color(200, 200, 200))

TEAM_HUMAN = 1
team.SetUp(TEAM_HUMAN,		"Human", Color(255, 215, 140))

TEAM_COMBINE = 2
team.SetUp(TEAM_COMBINE,	"Loyal", Color(60, 160, 255))

--Team check for players on Humans
function IsHuman(ply)
    if ply:Team() == TEAM_HUMAN then return true end

    return false
end

--Team check for players on Combine
function IsCombine(ply)
    if ply:Team() == TEAM_COMBINE then return true end

    return false
end

-- player:Alive() exists, this is useless
--
-- function IsAlive(ply)

--     if then return true end
--     return false
-- end

--Team check if players are in a miscellanous team (AFK or Connecting etc.)
function IsMiscTeam(ply)
    if not IsHuman(ply) or not IsCombine(ply) then return true end

    return false
end

function hl2c_player:IsTeam(iTeam)
    return self:Team() == iTeam or false
end

function HL2C_Global:GetHumans()
	local list = {}
	for i, ply in ipairs( player.GetAll() ) do
		if IsHuman(ply) then
			table.insert( list, ply )
		end
	end
	return list
end

function HL2C_Global:GetCombine()
	local list = {}
	for i, ply in ipairs( player.GetAll() ) do
		if IsCombine(ply) then
			table.insert( list, ply )
		end
	end
	return list
end