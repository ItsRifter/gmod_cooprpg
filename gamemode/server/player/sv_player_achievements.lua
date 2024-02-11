function hl2c_player:HasAchievement(id)
	local data = self.hl2c_data
	return table.HasValue(data.Achievements, id)
end

function hl2c_player:SetUpAchievementTracker()

end

function hl2c_player:GiveAchievement(id)
    --local ach = HL2C_Global:GetAchievementInfo(strName)
	local ach = HL2C_Ach:GetAchievement(id)
	
	if self:IsBot() then return end
	if self:HasAchievement(id) then return end
	
	if not ach then 
		HL2C_Server:DebugMsg(id.." not a valid achievement",HL2C_DEBUG_FAILED)
		return 
	end

	if ach.Secret then
		HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, self:Nick(), HL2R_TEXT_NORMAL, "##Ach_Earned_Secr",HL2R_TEXT_ORANGE, "##"..ach.Name)
	else
		HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, self:Nick(), HL2R_TEXT_NORMAL, "##Ach_Earned",HL2R_TEXT_ORANGE, "##"..ach.Name)
	end

	local data = self.hl2c_data
	
	table.insert(data.Achievements, id)
	net.Start("HL2C_AchievementEarned")
		--net.WriteString(group)
		net.WriteString(id)
	net.Send(self)
	
	if ach.Rewards then
		if ach.Rewards.XP and ach.Rewards.XP > 0 then
			--self:AddXP(ach.Rewards.XP)
		end
		--if ach.Rewards.Items then
		--	for k, v in pairs( ach.Rewards.Items ) do
		--		self:GiveItem(v)
		--	end
		--end
		--if ach.Rewards.AP then
		--	self:AddAP(ach.Rewards.AP)
		--end
	end
	
end

function hl2c_player:UpdateAchievementProgress(id, value)
	local ach = HL2C_Ach:GetAchievement(id)
	
	if self:IsBot() then return end
	if self:HasAchievement(id) then return end
	
	if not ach then 
		HL2C_Server:DebugMsg(string.format("%s is not a valid achievement", id), HL2C_DEBUG_FAILED)
		return 
	end
	
	if !ach.Max then
		HL2C_Server:DebugMsg(string.format("%s is not a progressive Achievement", id), HL2C_DEBUG_FAILED)
		return
	end

	local newcount = 0
	
	local data = self.hl2c_data
	
	if not ach.Count then	--Achievements that use a key table
		if not data.AchProgress[id] then data.AchProgress[id] = {} end
		if table.HasValue(data.AchProgress[id], value) then return end

		table.insert(data.AchProgress[id], value)
		newcount = table.Count(data.AchProgress[id])

		if newcount >= ach.Max then
			self:GiveAchievement(id)
			table.Empty(data.AchProgress[id])
			data.AchProgress[id] = nil  
			return
		end
	else
		if not data.AchProgress[id] then data.AchProgress[id] = 0 end

		newcount = data.AchProgress[id] + value
		data.AchProgress[id] = newcount

		if newcount >= ach.Max then
			self:GiveAchievement(id)
			data.AchProgress[id] = nil  
			return
		end
	end

	net.Start("HL2C_AchievementUpdate")
		--net.WriteString(group)
		net.WriteString(id)
		net.WriteUInt(newcount, 32)
	net.Send(self)
end

----------------Network----------------

--max compressed size is theory limited to 65,536 bytes
--we never hit this in previous version but something I ponder about.
function hl2c_player:SendAchievements()
	if self:IsBot() then return end
	local data = self.hl2c_data
	
	local datajson = util.TableToJSON( data.Achievements )
	local compressed = util.Compress( datajson )
	local bytes = #compressed

	net.Start( "HL2C_AchievementSend" )
		net.WriteUInt( bytes, 16 )
		net.WriteData( compressed, bytes )
	net.Send( self )
	
	local progress = {}
	
	--When sending ach progress to players, the whole table is not sent but converted to a simple value count
	for k, v in pairs( data.AchProgress) do
		if istable(v) then
			progress[k] = #v
		else
			progress[k] = v
		end
	end
	
	datajson = util.TableToJSON( progress )
	compressed = util.Compress( datajson )
	bytes = #compressed
	
	net.Start( "HL2C_AchievementProg" )
		net.WriteUInt( bytes, 16 )
		net.WriteData( compressed, bytes )
	net.Send( self )
end

function HL2C_Ach:SendAchievements(ply)
	ply:SendAchievements()
end

function HL2C_Ach:GiveHumansAchievement(id)
	local ach = HL2C_Ach:GetAchievement(id)
	
	if not ach then 
		HL2C_Server:DebugMsg(id.." not a valid achievement",HL2C_DEBUG_FAILED)
		return 
	end

	for i, pl in ipairs( HL2C_Global:GetHumans() ) do
		pl:GiveAchievement(id)
	end
	
end
