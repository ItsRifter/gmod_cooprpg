local hl2c_player = FindMetaTable("Player")

TEAM_CONNECTED = 0
team.SetUp(TEAM_CONNECTED		,"Connected", Color(255, 215, 140))

TEAM_AFK = 5
team.SetUp(TEAM_AFK				,"AFK", Color(255, 215, 140))

TEAM_SPEC = 9
team.SetUp(TEAM_SPEC            ,"Observer", Color(200, 200, 200))

TEAM_HUMAN_ALIVE = 1
team.SetUp(TEAM_HUMAN_ALIVE		,"Human", Color(255, 215, 140))
TEAM_HUMAN_DEAD = 10
team.SetUp(TEAM_HUMAN_DEAD		,"Human", Color(255, 215, 140))
TEAM_HUMAN_FIN = 11
team.SetUp(TEAM_HUMAN_FIN		,"Human", Color(255, 215, 140))

TEAM_COMBINE_ALIVE = 2
team.SetUp(TEAM_COMBINE_ALIVE	,"Loyal", Color(60, 160, 255))
TEAM_COMBINE_DEAD = 20
team.SetUp(TEAM_COMBINE_DEAD	,"Loyal", Color(60, 160, 255))

--Team check for players on Humans
function IsHuman(ply)
    local curTeam = ply:Team()

    if (curTeam == TEAM_HUMAN_ALIVE or curTeam == TEAM_HUMAN_DEAD
        or curTeam == TEAM_HUMAN_FIN) then return true end
    return false
end

--Team check for players on Combine
function IsCombine(ply)
    local curTeam = ply:Team()
    if (curTeam == TEAM_COMBINE_ALIVE or curTeam == TEAM_COMBINE_DEAD) then return true end
    return false
end

function IsAlive(ply)
    local curTeam = ply:Team()
    if (curTeam == TEAM_HUMAN_ALIVE or curTeam == TEAM_COMBINE_ALIVE) then return true end
    return false
end

--Team check if players are in a miscellanous team (AFK or Connecting etc.)
function IsMiscTeam(ply)
    if not IsHuman(ply) or not IsCombine(ply) then return true end
    return false
end

function hl2c_player:IsTeam(iTeam)
    return self:Team() == iTeam or false
end