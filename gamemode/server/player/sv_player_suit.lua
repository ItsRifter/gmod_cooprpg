local TICK_NAME = "HL2C_SUITTICK"
local TICK_RATE = 1

local hl2c_player = FindMetaTable("Player")
local delay = 0	--used to delay sending power to lower data sent as its not vital to be exact

function HL2C_Server:PerformSuitTick()
	for i, ply in ipairs( player.GetAll() ) do
		if ply:IsTeam(TEAM_HUMAN_ALIVE) then			
			ply:SuitTick()
			if delay <= 0 then ply:SendPower() end
		end
	end

	if delay <= 0 then delay = 2 end
	delay = delay - 1
end

-- function HL2C_Server:SetupSuits()
-- 	if timer.Exists(TICK_NAME) then timer.Remove(TICK_NAME) end

-- 	timer.Create(TICK_NAME, TICK_RATE, 0, function() HL2C_Server:SuitTick() end)
-- end

---------------------------------------------------------------

function hl2c_player:CreateAuxTimer()
	timer.Create(TICK_NAME, self.AuxSuit.TickRate, 0, function() HL2C_Server:SuitTick() end)
end

function hl2c_player:SetupSuit()
	self.AuxSuit = {}

	self:AllowFlashlight(true)
	self.AuxSuit.suitpower 	= 100	--flashlight power, maybe other things later?
	self.AuxSuit.stamina 	= 100	--sprinting and breathing power
	self.AuxSuit.exhausted	= false	--exausted state
	self.AuxSuit.drowning	= 0		--damage taken from drowning to restore later
	self.AuxSuit.suited		= true
	self.AuxSuit.TickRate = TICK_RATE
	self.AuxSuit.TickFunc = self:CreateAuxTimer()

	self:SendPower()
	self.AuxSuit.oldsuitpower = self.AuxSuit.suitpower
end

function hl2c_player:GetSuit()
	self:ValidateSuit()

	return self.AuxSuit
end

//Checks if the suit is valid
function hl2c_player:ValidateSuit()
	if self.AuxSuit == nil then
		self:SetupSuit()
	end
end

function hl2c_player:SuitTick()
	//TODO: add other power expenses

	local charge = 0.25

	if self:FlashlightIsOn() then
		charge = charge - 2
	end
	
	local suit = self:GetSuit()
	test = test - 1
	--self.AuxSuit.suitpower = math.Clamp(self.AuxSuit.suitpower + charge, 0, 100)
	//suit.suitpower = math.Clamp(suit.suitpower + charge, 0, 100)
	
	if self.AuxSuit.suitpower < 1 then
		self:Flashlight(false)
		self:AllowFlashlight(false)
	else
		if self.AuxSuit.suitpower > 5 then self:AllowFlashlight(true) end
	end
end

function hl2c_player:SendPower()
	local suit = self:GetSuit()
	
	if suit.suitpower == suit.oldsuitpower then return end	--saves sending same values repeatedly

	net.Start("HL2C_Suit_Power")
		net.WriteFloat( suit.suitpower )
	net.Send(self)
	
	suit.oldsuitpower = suit.suitpower
end

--hook.Add( "PlayerSwitchFlashlight", "SuitFlashLight", function( ply, enabled )
--	net.Start("HL2C_Suit_FlashLight")
--		net.WriteBool( enabled )
--	net.Send(ply)
--end )

function ValidateAuxSuits()
	for _, p in ipairs(player.GetAll()) do
		p:SetupSuit()
		//p:ValidateSuit()
		//p.AuxSuit.TickRate = TICK_RATE
		//p.AuxSuit.TickFunc = self:CreateAuxTimer()
	end
end

ValidateAuxSuits()