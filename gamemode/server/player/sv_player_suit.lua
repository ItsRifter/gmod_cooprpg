local TICK_NAME = "HL2C_SUITTICK"
local TICK_RATE = 1 / 20

local delay = 0	--used to delay sending power to lower data sent as its not vital to be exact

function HL2C_Server:SuitTick()
	for i, ply in ipairs( player.GetAll() ) do
		if ply:IsTeam(TEAM_HUMAN) then
			ply:SuitTick()
			if delay <= 0 then 
				ply:SendPower() ply:SendStamina() 
			end
		end
	end

	if delay <= 0 then delay = 4 end
	delay = delay - 1
end

function HL2C_Server:SetupSuits()
	--self:DebugMsg("Starting SuitTick Timer", HL2C_DEBUG_STANDARD)

	if timer.Exists(TICK_NAME) then timer.Remove(TICK_NAME) end
	timer.Create(TICK_NAME, TICK_RATE, 0, function() HL2C_Server:SuitTick() end)
end

HL2C_Server:SetupSuits()

---------------------------------------------------------------

function hl2c_player:SetupSuit()
	if HL2C_Global:NoSuit() then
		self:AllowFlashlight(false)
	else
		self:AllowFlashlight(true)
	end
	
	self:AdjustSpeed()
	
	self.suit = {}
	self.suit.power 	= 100	--flashlight power, maybe other things later?
	self.suit.stamina 	= 100	--sprinting and breathing power
	self.suit.exhausted	= false	--exausted state
	self.suit.drowning	= 0		--damage taken from drowning to restore later
	self.suit.suited	= not HL2C_Global:NoSuit()	--Is this needed now with global no suit var?
	
	self:SendPower()
	self:SendStamina()
	
	self.suit.oldpower = self.suit.power
	self.suit.oldstamina = self.suit.stamina
end

function hl2c_player:SuitTick()
	local suit = self:GetSuit()

	if HL2C_Global:NoSuit() then return end	--any code after this is just for when players are suited
	
	local charge = 0.25
	if self:FlashlightIsOn() then
		charge = charge - 0.75
	end
	
	suit.power = math.Clamp(suit.power + charge,0,100)
	
	if suit.power < 1 then
		self:Flashlight( false )
		self:AllowFlashlight( false)
	else
		if suit.power > 5 then self:AllowFlashlight( true) end
	end
	
	local regen = 0.2
	
	if self:WaterLevel() == 3 then 
		regen = regen - 0.5 
		
		if suit.stamina < 1 then
			if not self.suit.drowntick or self.suit.drowntick < CurTime() then
				suit.drowntick = CurTime() + 1
				suit.drowning = self.suit.drowning + 5
				
				local dmginfo = DamageInfo()
				dmginfo:SetDamage(5)
				dmginfo:SetDamageType(DMG_DROWN)
				dmginfo:SetAttacker(self)
				dmginfo:SetInflictor(self)
				dmginfo:SetDamageForce(Vector(0, 0, 0))
			  
				-- Take drowning damage
				self:TakeDamageInfo(dmginfo)
			end
		end
	else
		if suit.stamina > 40 and suit.drowning > 0 then
			if not self.suit.drowntick or self.suit.drowntick < CurTime() then
				suit.drowntick = CurTime() + 1
				self:SetHealth(math.Clamp(self:Health() + 5 , 0, self:GetMaxHealth()))
				suit.drowning = suit.drowning - 5
			end
		end
	end
	
	if self:IsSprinting() and self:UsingMoveInput() and self:GetVelocity():Length() > self:GetWalkSpeed() + 20 then 
		regen = regen - 0.8 
	end
	
	suit.stamina = math.Clamp(suit.stamina + regen,0,100)
	
	if suit.stamina > 95 and suit.exhausted then suit.exhausted = false 
		self:SetMaxSpeed(350)
		self:SetWalkSpeed(200)
		self:SetRunSpeed(350)
	end
	
	if suit.stamina < 1 and not suit.exhausted then suit.exhausted = true 
		self:SetMaxSpeed(180)
		self:SetWalkSpeed(180)
		self:SetRunSpeed(180)
	end
end

function hl2c_player:GetSuit()
	if not self.suit then self:SetupSuit(true) end
	return self.suit
end

function hl2c_player:SendPower()
	local suit = self:GetSuit()
	if suit.power == suit.oldpower then return end	--saves sending same values repeatedly
	
	net.Start("HL2C_Suit_Power")
		net.WriteFloat( suit.power )
	net.Send(self)
	
	suit.oldpower = suit.power
end

function hl2c_player:SendStamina()
	local suit = self:GetSuit()
	if suit.stamina == suit.oldstamina then return end	--saves sending same values repeatedly
	
	net.Start("HL2C_Suit_Stamina")
		net.WriteFloat( suit.stamina )
	net.Send(self)
	
	suit.oldstamina = suit.stamina
end

function hl2c_player:UsingMoveInput()
	return self:KeyDown(IN_FORWARD) or self:KeyDown(IN_BACK) or self:KeyDown(IN_MOVELEFT) or self:KeyDown(IN_MOVERIGHT)
end

--hook.Add( "PlayerSwitchFlashlight", "SuitFlashLight", function( ply, enabled )
--	net.Start("HL2C_Suit_FlashLight")
--		net.WriteBool( enabled )
--	net.Send(ply)
--end )