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

HL2C_MapList:AddMapFiles()

//hook.Add("InitPostEntity", "HL2C_Map_Init", HL2C_MapList:Init())
hook.Add("PostCleanupMap", "HL2C_Map_Init_Cleanup", HL2C_MapList:Init())