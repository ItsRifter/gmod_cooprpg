SUIT_OXYGEN = {}

local flashlight_expense = 0.20
local expense_active = false

function SUIT_OXYGEN:DoTick(ply)
    -- if self:WaterLevel() == 3 then 
	-- 	regen = regen - 0.5 
		
	-- 	if suit.stamina < 1 then
	-- 		if not self.suit.drowntick or self.suit.drowntick < CurTime() then
	-- 			suit.drowntick = CurTime() + 1
	-- 			suit.drowning = self.suit.drowning + 5
				
	-- 			local dmginfo = DamageInfo()
	-- 			dmginfo:SetDamage(5)
	-- 			dmginfo:SetDamageType(DMG_DROWN)
	-- 			dmginfo:SetAttacker(self)
	-- 			dmginfo:SetInflictor(self)
	-- 			dmginfo:SetDamageForce(Vector(0, 0, 0))
			  
	-- 			-- Take drowning damage
	-- 			self:TakeDamageInfo(dmginfo)
	-- 		end
	-- 	end
	-- else
	-- 	if suit.stamina > 40 and suit.drowning > 0 then
	-- 		if not self.suit.drowntick or self.suit.drowntick < CurTime() then
	-- 			suit.drowntick = CurTime() + 1
	-- 			self:SetHealth(math.Clamp(self:Health() + 5 , 0, self:GetMaxHealth()))
	-- 			suit.drowning = suit.drowning - 5
	-- 		end
	-- 	end
	-- end
end

function SUIT_OXYGEN:IsExpenseActive()
    return expense_active
end

function SUIT_OXYGEN:DoExpense(ply)
    ply.suit.power = math.Clamp(ply.suit.power - flashlight_expense, 0, 100)
end