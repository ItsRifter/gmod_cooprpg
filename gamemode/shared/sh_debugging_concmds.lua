local function AutoComplete_Players(cmd, strArgs)
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

local function FindPlayer(strName)
    strName = strName:lower()
    for _, p in pairs(player.GetAll()) do
        local name = p:Nick()

        if name:lower():find(strName) then
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
    function TryPlayerDataWipe(ply, targetArg)
        if not IsPlayerPermitted(ply) then return end

        local targetArg = targetArg
        --No target specified so use the calling player
        if not IsStringValid(targetArg) then
            HL2C_Data:WipeData(ply)
        else
            local target = FindPlayer(targetArg)
            if not IsValid(target) then HL2C_Server:DebugMsg("No target found", HL2C_DEBUG_FAILED) return end
    
            HL2C_Data:WipeData(target)
        end
    end

    net.Receive("HL2C_Data_DoWipe", function(len, ply)
        TryPlayerDataWipe(ply, net.ReadString())
    end)
end

if CLIENT then
    local waitPeriod = 0.2
    local cooldown = 0

    concommand.Add("hl2c_admin_data_wipe", function(ply, cmd, args)
        if cooldown > CurTime() then return end
        
        cooldown = CurTime() + waitPeriod

        net.Start("HL2C_Data_DoWipe")
            net.WriteString(args[1])
        net.SendToServer()
    end, AutoComplete_Players)
end