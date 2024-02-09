HL2C_Global.Achievements = {}

function HL2C_Global:CreateAchievement(strName, strDesc, strIcon, funcs)        
    local achTbl = {
        ["Name"] = strName,
        ["Desc"] = strDesc,
        ["Icon"] = strIcon,
        ["Functions"] = funcs
    }

    table.insert(HL2C_Global.Achievements, achTbl)
end

function HL2C_Global:GetAchievementInfo(strTarget)
    local ach = nil
    strTarget = strTarget:lower()

    for _, a in pairs(HL2C_Global.Achievements) do 
        local name = a.Name

        if name:lower():find(strTarget) then
            ach = a
        end
    end

    return ach
end

function HL2C_Global:GiveAchievement(strName, targets, bToAll)
    if bToAll then
        print("EVERYONE")
    end
end