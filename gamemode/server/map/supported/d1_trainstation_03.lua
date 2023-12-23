local MAP_NAME = "d1_trainstation_03"
local MAP_FUNC = {}

function MAP_FUNC:SetUp()
    
end

function CreateLogicEnts()

end

function CreateGameEnts()

end

local function PreSetUp()
    local map = {
        ["Map"] = {
            MapName = MAP_NAME,
            Func = MAP_FUNC
        }
    }
    
    HL2C_MapList:AddMapToList(map)
end

PreSetUp()