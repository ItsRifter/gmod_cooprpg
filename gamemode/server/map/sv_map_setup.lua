HL2C_MapList = {
    Maps = {}
}

local function GetMapFile(target)
    local foundMap = nil

    for _, m in ipairs(HL2C_MapList.Maps) do
        if(m.MapName == target) then
            foundMap = m
            break
        end
    end

    return foundMap
end

function HL2C_MapList:Init()
    local curMap = GetMapFile(game.GetMap())
    if curMap == nil then return end

    curMap.Func.SetUp()
end

function HL2C_MapList:AddMapFiles()
    local folderPath = GM.FolderName .. "/gamemode/server/map/supported/"

    local maps = file.Find( folderPath .. "*.lua", "LUA")

    for _, m in ipairs(maps) do
        include(folderPath .. m)
    end
end

function HL2C_MapList:AddMapToList(mapFile)    
    table.Add(HL2C_MapList.Maps, mapFile)
end

local default_globalVars = {
    "actlion_allied",
    "suit_no_sprint",
    "super_phys_gun",
    "friendly_encounter",
    "gordon_invulnerable",
    "no_seagulls_on_jeep",

    "ep_alyx_darknessmode",

    "ep2_alyx_injured",
    "hunters_to_run_over"
}

local mapset_globalvars = {}

function HL2C_MapList:SetGlobalVar(globalVar, value)
    if value < 0 or value > 3 then return end

    game.SetGlobalState(globalVar, value)

    if not table.HasValue(mapset_globalvars, globalVar) then
        table.insert(mapset_globalvars, globalVar)
    end
end

function HL2C_MapList:ResetExcludedGlobalVars()
    local globalTbl = default_globalVars

    for i, g in ipairs(mapset_globalvars) do
        table.RemoveByValue(globalTbl, g)
    end

    for _, v in ipairs(globalTbl) do
        game.GetGlobalState(v, 0)
    end
end

HL2C_MapList:AddMapFiles()

//hook.Add("InitPostEntity", "HL2C_Map_Init", HL2C_MapList:Init())
hook.Add("PostCleanupMap", "HL2C_Map_Init_Cleanup", HL2C_MapList:Init())

hook.Add("IsSpawnpointSuitable", "HL2C_MakeSpawnsNotKill", function(ply, spawnpoint, makeSuitable)
    makeSuitable = false
    return true
end)