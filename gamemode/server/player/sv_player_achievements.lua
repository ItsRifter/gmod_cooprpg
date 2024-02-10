function hl2c_player:SetUpAchievementTracker()

end

function hl2c_player:GiveAchievement(strName)
    --local ach = HL2C_Global:GetAchievementInfo(strName)
	local ach = HL2C_Ach:GetAchievement(strName)
	if not ach then 
		HL2C_Server:DebugMsg(strName.." not a valid achievement",HL2C_DEBUG_FAILED)
		return 
	end

	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, self:Nick(), HL2R_TEXT_NORMAL, "##Ach_Earned",HL2R_TEXT_ORANGE, "##"..ach.Name)
end

function hl2c_player:UpdateAchievementProgress()

end