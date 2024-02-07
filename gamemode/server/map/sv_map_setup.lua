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

function HL2C_Map:RemoveMapEnts(list)
    for _, v in ipairs(list) do
        local ent = ents.GetMapCreatedEntity(v)
		if IsValid(ent) then ent:Remove() end
    end
end

function HL2C_Map:SetMapEntsHealth(list,health)
    for _, v in ipairs(list) do
        local ent = ents.GetMapCreatedEntity(v)
		if IsValid(ent) then ent:SetHealth( health ) end
    end
end

function HL2C_Map:RemoveNamedEnts(name)
	local list = ents.FindByName(name )
    for _, v in ipairs(list) do
        v:Remove()
    end
end

--Im not really happy with this func but it seems to work decently now and thankfully only processes once, I could possibly custom do the seach to avoid recycling the ent list but think its minimal.
function HL2C_Map:RemoveNewGameEnts()	--Valve, for fuck sake, cant you name the newgame items the same thing?
	if true then return end
	
	--can hope this works for all maps or give up and find the ents on each map individually.
	local list = ents.FindByName("global_newgame_*" )
	table.Add( list, ents.FindByName("player_spawn_*" ) )
	table.Add( list, ents.FindByName("start_item_*" ) )
	table.Add( list, ents.FindByName("spawnitems_*" ) )
	table.Add( list, ents.FindByName("startobjects*" ) )
    for _, v in ipairs(list) do
		local cl = v:GetClass()
		
		if string.StartsWith( cl, "weapon_") or string.StartsWith( cl, "item_suit") then v:Remove() end

		--if v:GetClass() then
        --v:Remove()
    end
	
end

--This is getting ridiculous now
hook.Add( "OnEntityCreated", "Remove_NewGameStuff", function( ent )
	timer.Simple( 0.1, function()
		if not IsValid(ent) then return end
		local cl = ent:GetClass()
		
		local name = ent:GetName()
		if string.StartsWith( cl, "weapon_") or string.StartsWith( cl, "item_suit") then
			if string.StartsWith( name, "global_newgame_") 
			or string.StartsWith( name, "player_spawn_") 
			or string.StartsWith( name, "start_item_") 
			or string.StartsWith( name, "spawnitems") 
			or string.StartsWith( name, "startobjects") then
				ent:Remove()
			end
		end
		if name == "global_newgame_template_ammo" then ent:Remove() end
		if name == "global_newgame_template_local_items" then ent:Remove() end
	
	end  )
end )

function HL2C_Map:FireEnts(name,value)
	for _, ent in ipairs(ents.FindByName( name )) do
		ent:Fire(value)
	end
end

hook.Add("InitPostEntity", "HL2C_Map_Init_Startup", function() HL2C_Server:SetupMap() end)
hook.Add("PostCleanupMap", "HL2C_Map_Init_Cleanup", function() HL2C_Server:SetupMap() end)

hook.Add("IsSpawnpointSuitable", "HL2C_MakeSpawnsNotKill", function(ply, spawnpoint, makeSuitable)
    makeSuitable = false
    return true
end)