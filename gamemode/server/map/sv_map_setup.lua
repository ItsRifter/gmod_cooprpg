HL2C_Map = {}

function HL2C_Map:Init()
    local filepath = GM.FolderName .. "/gamemode/server/map/supported/"..game.GetMap()..".lua"
    --local mapfile = file.Exists( filepath, "LUA")

	if file.Exists( filepath, "LUA") then
		include(filepath)
		--print(game.GetMap().." lua loaded")
	else
		HL2C_Server:DebugMsg(game.GetMap().." lua not found", 2)
	end
end
HL2C_Map:Init()

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

function HL2C_Map:SetGlobalVar(globalVar, value)
    if value < 0 or value > 2 then return end  --0 offstate - 1 onstate - 2 deadstate

    game.SetGlobalState(globalVar, value)

    if not table.HasValue(mapset_globalvars, globalVar) then
        table.insert(mapset_globalvars, globalVar)
    end
end

function HL2C_Map:ResetExcludedGlobalVars()
    local globalTbl = default_globalVars

    for i, g in ipairs(mapset_globalvars) do
        table.RemoveByValue(globalTbl, g)
    end

    for _, v in ipairs(globalTbl) do
        game.GetGlobalState(v, 0)
    end
end

hook.Add("InitPostEntity", "HL2C_Map_Init_Startup", function() HL2C_Server:SetupMap() end)
hook.Add("PostCleanupMap", "HL2C_Map_Init_Cleanup", function() HL2C_Server:SetupMap() end)

hook.Add("IsSpawnpointSuitable", "HL2C_MakeSpawnsNotKill", function(ply, spawnpoint, makeSuitable)
    makeSuitable = false
    return true
end)