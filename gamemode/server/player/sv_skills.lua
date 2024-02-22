
function hl2c_player:SkillsOnSpawn()
	self:SetMaxHealth( 100)
	self:SetMaxArmor( 100)

	self.suit.flashdrain = 1	--Used as multiplier so 1 is default rate

	--activate all skills player has that have an onspawn func here
	for k,v in pairs(self.hl2c_data.Skills) do
		local skilldata = HL2C_Skills:GetSkill(v)
		if skilldata.onspawn then skilldata.onspawn(self) end
	end

	self:SetHealth( self:GetMaxHealth())
	--self:SetArmor( self:GetMaxArmor())
end

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function hl2c_player:AddMaxHealth(amount)
	self:SetMaxHealth( self:GetMaxHealth() + amount)
end

function hl2c_player:AddMaxArmour(amount)
	self:SetMaxArmor(self:GetMaxArmor() + amount)
end

function hl2c_player:AddFlashDrain(amount)
	self.suit.flashdrain = self.suit.flashdrain + amount
end

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function hl2c_player:HasSkill(skill)
	return table.HasValue( self.hl2c_data.Skills,skill)
end

function hl2c_player:GiveSkill(skill)
	--print("Trying to give skill "..skill)
	local skilldata = HL2C_Skills:GetSkill(skill)
	if not skilldata then return end
	if self:HasSkill(skill) then return end
	if not self:SkillUnlocked(skill) then return end

	--print("Giving skill "..skill)
	table.insert(self.hl2c_data.Skills,skill)

end

function hl2c_player:SkillUnlocked(skill)
	--check if skill has prequisits unlocked
	local skilldata = HL2C_Skills:GetSkill(skill)
	if not skilldata then return false end
	if skilldata.required then
		for k,v in pairs(skilldata.required ) do
			if not self:HasSkill(v) then return false end
		end
	end
	return true
end

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

concommand.Add("hl2c_giveskill", function( ply, cmd, args )
	if !ply:IsSuperAdmin() then return end
	local skill = args[1]
	local skilldata = HL2C_Skills:GetSkill(skill)
	if not skilldata then return end
	
	ply:GiveSkill(skill)
end)

concommand.Add("hl2c_showskill", function( ply, cmd, args )
	if !ply:IsSuperAdmin() then return end
	PrintTable(ply.hl2c_data.Skills)
end)