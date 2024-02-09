function hl2c_player:SetUpAchievementTracker()

end

function hl2c_player:GiveAchievement(strName)
    local ach = HL2C_Global:GetAchievementInfo(strName)

    ach["Functions"].OnObtain(self)

    --table.RemoveByValue(ach, ach.Funcs)s
    self:ChatPrint(string.format("You got achievement \"%s\" which is for \"%s\"", ach.Name, ach.Desc))
end

function hl2c_player:UpdateAchievementProgress()

end