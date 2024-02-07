

function hl2c_player:AddExp(amount)
	if self:IsBot() or not self.data_loaded then return end
	if amount <=0 then return end

	local data = self.hl2c_data
	data.Exp 	= data.Exp + amount
	if data.Next <= 0 then data.Next = self:ExpRequired() self:SetNWInt("hl2c_stat_expreq", data.Next) end
	
	if data.Exp >= data.Next then
		self:OnLevel()
	end
	
	self:SetNWInt("hl2c_stat_exp", data.Exp)
end

function hl2c_player:OnLevel()
	local data = self.hl2c_data
	
	if data.Exp < data.Next then return end
	data.Exp = data.Exp - data.Next
	data.Level = data.Level + 1
	data.Next = self:ExpRequired()

	self:SetNWInt("hl2c_stat_level", data.Level)
	self:SetNWInt("hl2c_stat_expreq", data.Next)	
end

--407,454,517,599,706,841,1011
function hl2c_player:ExpRequired(level)
	level = level or self.hl2c_data.Level
	return 319 + math.floor(math.pow( level + 6, 2.5 + (level * 0.022 )))
end