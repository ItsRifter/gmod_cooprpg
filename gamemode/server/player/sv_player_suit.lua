
local TICK_NAME = "HL2C_SUITTICK"
local TICK_RATE = 1 / 20

SUIT_EXPENSES = {}

TICK_FLASHLIGHT_REGEN = 0.15
TICK_STAMINA_REGEN = 0.20

local delay = 0	--used to delay sending power to lower data sent as its not vital to be exact

function HL2C_Server:SuitTick()
	for i, ply in ipairs( player.GetAll() ) do
		if ply:IsTeam(TEAM_HUMAN) then
			ply:SuitTick()
			if delay <= 0 then
				ply:SendPower() 
				ply:SendStamina() 
			end
		end
	end

	if delay <= 0 then delay = 4 end
	delay = delay - 1
end

-- function HL2C_Server:SetupSuits()
-- 	--self:DebugMsg("Starting SuitTick Timer", HL2C_DEBUG_STANDARD)

-- 	--if timer.Exists(TICK_NAME) then timer.Remove(TICK_NAME) end
-- 	--timer.Create(TICK_NAME, TICK_RATE, 0, function() HL2C_Server:SuitTick() end)

-- 	for _, p in pairs(player.GetAll()) do
-- 		p:SetupSuit()
-- 	end
-- end

function HL2C_Server:ResetSuits()
	for _, p in pairs(player.GetAll()) do 
		--Player hasn't been setup beforehand
		if not p.suit then continue end
		
		p:SetupSuit()
	end

	table.Empty(SUIT_EXPENSES)

	SUIT_EXPENSES = {
		[1] = SUIT_FLASHLIGHT,
		[2] = SUIT_OXYGEN
	}
end

HL2C_Server:ResetSuits()

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
	self.suit.exhausted	= false	--exhausted state
	self.suit.drowning	= 0		--damage taken from drowning to restore later
	self.suit.suited	= not HL2C_Global:NoSuit()	--Is this needed now with global no suit var?

	self:SendPower()
	self:SendStamina()
	
	self.suit.oldpower = self.suit.power
	self.suit.oldstamina = self.suit.stamina

	SUIT_EXPENSES = {
		[1] = SUIT_FLASHLIGHT,
		[2] = SUIT_OXYGEN
	}

	local timerName = "suit_tick_" .. self:EntIndex()

	if timer.Exists(timerName) then timer.Remove(timerName) end
	timer.Create(timerName, TICK_RATE, 0, function() self:SuitTick() end)
end

local powerRegen_waitTime = 3.5
local powerRegen_cooldown = 0

function hl2c_player:SuitTick()
	local suit = self:GetSuit()

	if HL2C_Global:NoSuit() then return end	--any code after this is just for when players are suited
	
	--Check if expenses exist and not empty
	if SUIT_EXPENSES ~= nil and not table.IsEmpty(SUIT_EXPENSES) then
		--Tick suit expenses
		for _, ex in pairs(SUIT_EXPENSES) do
			ex:DoTick(self)
			
			if ex:IsExpenseActive() then
				ex:DoExpense(self)
			end
		end
	end
	
	self:SendPower()
	self:SendStamina()

	--If power is draining
	if self.suit.power < self.suit.oldpower then
		powerRegen_cooldown = CurTime() + powerRegen_waitTime
	else
		if powerRegen_cooldown > CurTime() then return end

		self.suit.power = math.Clamp(self.suit.power + TICK_FLASHLIGHT_REGEN, 0, 100)
	end
	
	local regen = 0.2
	
	if self:IsSprinting() and self:UsingMoveInput() and self:GetVelocity():Length() > self:GetWalkSpeed() + 20 then 
		regen = regen - 0.8 
	end
	
	suit.stamina = math.Clamp(suit.stamina + regen, 0, 100)
	
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