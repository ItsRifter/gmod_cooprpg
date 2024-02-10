HL2C_Ach.AchEarned = HL2C_Ach.AchEarned or {}
HL2C_Ach.AchProgress = HL2C_Ach.AchProgress or {}

net.Receive( "HL2C_AchievementSend", function( length)
	local bytes = net.ReadUInt( 16 )
	local compressed = net.ReadData( bytes ) 
	local datajson = util.Decompress( compressed )

	HL2C_Ach.AchEarned = util.JSONToTable( datajson )
end )

net.Receive( "HL2C_AchievementProg", function( length)
	local bytes = net.ReadUInt( 16 )
	local compressed = net.ReadData( bytes ) 
	local datajson = util.Decompress( compressed )

	HL2C_Ach.AchProgress = util.JSONToTable( datajson )
end )

net.Receive("HL2C_AchievementEarned", function()
	local group = net.ReadString()
	local id = net.ReadString()

	local ach = HL2C_Ach:GetAchievement(group,id)
	--NewAchNotice(ach)
	table.insert(HL2C_Ach.AchEarned,id)
	if HL2C_Ach.AchProgress[id] then HL2C_Ach.AchProgress[id] = nil end

end)

net.Receive("HL2C_AchievementUpdate", function()
	local group = net.ReadString()
	local id = net.ReadString()
	local count = net.ReadUInt(32)

	local ach = HL2C_Ach:GetAchievement(group,id)
	--NewAchNotice(ach,count)
	if !HL2C_Ach.AchProgress[id] then
		HL2C_Ach.AchProgress[id] = 0
	end
	if ach.Interval then
		if math.floor(count/ach.Interval)-math.floor(HL2C_Ach.AchProgress[id]/ach.Interval) > 0 then
			--NewAchNotice(ach,count)
		end
	else
		--NewAchNotice(ach,count)
	end
	HL2C_Ach.AchProgress[id] = count
	--local achNotifyTbl = net.ReadTable()
	--AchUpdateNotice(achNotifyTbl)
end)

function HL2C_Ach:HasAchievement(ach)
	return table.HasValue( HL2C_Ach.AchEarned,ach)
end

function HL2C_Ach:GetProgress(ach)
	if HL2C_Ach.AchProgress[ach] then return HL2C_Ach.AchProgress[ach] end
	return 0
end