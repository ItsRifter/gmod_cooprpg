local TICK_NAME = "HL2C_SUITTICK"
local TICK_RATE = 1 / 20

--local hl2c_player = FindMetaTable("Player")
local delay = 0	--used to delay sending power to lower data sent as its not vital to be exact

function HL2C_Server:SuitTick()
	for i, ply in ipairs( player.GetAll() ) do
		if ply:IsTeam(TEAM_HUMAN) then
			ply:SuitTick()
			if delay <= 0 then ply:SendPower() end
		end
	end
	if delay <= 0 then delay = 2 end
	delay = delay - 1
end

function HL2C_Server:SetupSuits()
	print("Starting SuitTick Timer")
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
	self.suit.oldpower = self.suit.power
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

--hook.Add( "PlayerSwitchFlashlight", "SuitFlashLight", function( ply, enabled )
--	net.Start("HL2C_Suit_FlashLight")
--		net.WriteBool( enabled )
--	net.Send(ply)
--end )