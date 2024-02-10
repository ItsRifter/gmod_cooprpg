local function AutoComplete_Players(cmd, strArgs)

    if not LocalPlayer():IsAdmin() then return nil end
	
    strArgs = string.Trim(strArgs:lower())

    local activePlys = {}

    for _, p in pairs(player.GetAll()) do
        local name = p:Nick()

        if name:lower():find(strArgs) then
            name = string.format("%s \"%s\"", cmd, name)
            table.insert(activePlys, name)
        end
    end

    return activePlys
end

local function AutoComplete_Achievements(cmd, strArgs)
    if not LocalPlayer():IsAdmin() then return nil end
    local allargs = string.Split( strArgs, " ")
	
	--PrintTable(allargs)
    local achArg = allargs[2]:lower()

    local possibleAchs = {}

    for k, v in pairs(HL2C_Ach:GetAllAchievements()) do
        local achName = k
        
        if achName:lower():find(achArg) then
            achName = string.format("%s %s", cmd, achName)
            table.insert(possibleAchs, achName)
        end
    end

    local targets = {}

	if table.Count( possibleAchs ) == 1 then
		if allargs[3] then
			local activePlys = {}

			for _, p in pairs(player.GetAll()) do
				local name = p:Nick()

				if name:lower():find(allargs[3]:lower()) then
					name = string.format("\"%s\"",  name)
					table.insert(activePlys, possibleAchs[1].." "..name)
				end
			end
			
			if table.Count( activePlys ) >0 then
				return activePlys
			end
		end

	end

    return possibleAchs
end

local function FindPlayer(strName)
    strName = strName:lower()
    for _, p in pairs(player.GetAll()) do
        local name = p:Nick():lower()

        if name:find(strName) then
            return p
        end
    end

    return nil
end

function IsPlayerPermitted(ply)
    --Could add extras for this -ItsRifter

    return ply:IsAdmin()
end

function IsStringValid(str)
    return str ~= nil or str ~= ''
end

if SERVER then
    local function TryPlayerDataWipe(ply, targetArg)
        if not IsPlayerPermitted(ply) then return end

        --No target specified so use the calling player
        if not IsStringValid(targetArg) then
            HL2C_Data:WipeData(ply)
        else
            local target = FindPlayer(targetArg)
            if not IsValid(target) then HL2C_Server:DebugMsg("No target found", HL2C_DEBUG_FAILED) return end
    
            HL2C_Data:WipeData(target)
        end
    end

    local function TryGivingAchievement(ply, achArg, target)
        if not IsPlayerPermitted(ply) then return end

        if not IsStringValid(target) then
            ply:GiveAchievement(achArg)
        else
            local target = FindPlayer(target)
            if not IsValid(target) then HL2C_Server:DebugMsg("No target found", HL2C_DEBUG_FAILED) return end

            target:GiveAchievement(achArg)
        end
    end

    net.Receive("HL2C_Admin_Data_DoWipe", function(len, ply)
        TryPlayerDataWipe(ply, net.ReadString())
    end)

    net.Receive("HL2C_Admin_Achievement_Give", function(len, ply)
        TryGivingAchievement(ply, net.ReadString(), net.ReadString())
    end)
end

if CLIENT then
    local waitPeriod = 0.2
    local cooldown = 0
    concommand.Add("hl2c_admin_data_wipe", function(ply, cmd, args)
        if not IsPlayerPermitted(LocalPlayer()) then return end
        
        if cooldown > CurTime() then return end
        cooldown = CurTime() + waitPeriod

        net.Start("HL2C_Admin_Data_DoWipe")
            net.WriteString(args[1] or "")
        net.SendToServer()
    end, AutoComplete_Players)

    concommand.Add("hl2c_admin_achievement_give", function(ply, cmd, args)
        if not IsPlayerPermitted(LocalPlayer()) then return end

        if cooldown > CurTime() then return end
        cooldown = CurTime() + waitPeriod

        if not IsStringValid(args[1]) then return end

        net.Start("HL2C_Admin_Achievement_Give")
            net.WriteString(args[1])
            net.WriteString(args[2] or "")
        net.SendToServer()

    end, AutoComplete_Achievements)
end