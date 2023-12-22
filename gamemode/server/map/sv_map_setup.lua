HL2C_MapList = HL2C_MapList or {}
HL2C_MapList.__index = HL2C_MapList


function HL2C_MapList:Init()
    setmetatable( , HL2C_MapList)
end

function HL2C_MapList:GetAllMaps()
    local mapList = file.Find(GM.FolderName .. "/gamemode/map/*", "LUA")
     
end

function HL2C_MapList:AddMapToList(mapFile)

end

HL2C_MapList:GetAllMaps()

hook.Add("Initialize", "HL2C_Map_Init", HL2C_MapList:Init())