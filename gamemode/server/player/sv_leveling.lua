function hl2c_player:AddExp(amount)
	if self:IsBot() or not self.data_loaded then return end
	if amount <=0 then return end

	local data = self.hl2c_data
	data.Exp = data.Exp + amount
	
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
	return HL2C_Server:ExpRequired(level)
end

function HL2C_Server:ExpRequired(level)
	return 164 + math.floor(math.pow( level + 6, 2 + (level * 0.015 )))
end

-- 164 + math.floor(math.pow( level + 6, 2 + (level * 0.015 )))
--| LVL     To Level   |      In Total   |
--|   0 =          200 |             200 |
--|   5 =          308 |            1485 |
--|  10 =          552 |            3687 |
--|  15 =         1038 |            7778 |
--|  20 =         1960 |           15508 |
--|  25 =         3647 |           29972 |
--|  30 =         6664 |           56569 |
--|  35 =        11974 |          104638 |
--|  40 =        21210 |          190199 |
--|  45 =        37125 |          340568 |
--|  50 =        64361 |          602108 |
--|  55 =       110713 |         1053199 |
--|  60 =       189257 |         1825962 |
--|  65 =       321895 |         3142567 |
--|  70 =       545270 |         5375911 |
--|  75 =       920646 |         9150942 |
--|  80 =      1550390 |        15513847 |
--|  85 =      2605480 |        26214485 |
--|  90 =      4371444 |        44177876 |
--|  95 =      7325047 |        74291353 |
--| 100 =     12262424 |       124718957 |



function HL2C_Server:ExpDebug()
	local text = ""
	local amount = 0 
	print("--| LVL     To Level   |      In Total   |")
	for i=0,100 do
		amount = amount + HL2C_Server:ExpRequired(i)
		--text = text.. string.format("| %3i = %12i |", i, HL2C_Server:ExpRequired(i))
		if i % 5 == 0 then
			print(string.format("--| %3i = %12i | %15i |", i, HL2C_Server:ExpRequired(i),amount))
			--text = ""
		end
	end
	
end