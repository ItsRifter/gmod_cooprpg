local TICK_NAME = "HL2C_SUITTICK"
local TICK_RATE = 1 / 20

local hl2c_player = FindMetaTable("Player")
local delay = 0	--used to delay sending power to lower data sent as its not vital to be exact

function HL2C_Server:SuitTick()
	for i, ply in ipairs( player.GetAll() ) do
		if ply:IsTeam(TEAM_HUMAN_ALIVE) then
			if not ply.suited then ply:SetupSuit() end
			ply:SuitTick()
			
			if delay <= 0 then ply:SendPower() end
		end
	end
	if delay <= 0 then delay = 2 end
	delay = delay - 1
end

function HL2C_Server:SetupSuits()
	if timer.Exists(TICK_NAME) then timer.Remove(TICK_NAME) end
	timer.Create(TICK_NAME, TICK_RATE, 0, function() HL2C_Server:SuitTick() end)
end
HL2C_Server:SetupSuits()

---------------------------------------------------------------

function hl2c_player:SetupSuit()
	self:AllowFlashlight( true)
	self.suitpower 	= 100	--flashlight power, maybe other things later?
	self.stamina 	= 100	--sprinting and breathing power
	self.exhausted	= false	--exausted state
	self.drowning	= 0		--damage taken from drowning to restore later
	self.suited		= true
	
	self:SendPower()
	self.oldsuitpower = self.suitpower
	
end

function hl2c_player:SuitTick()
	local charge = 0.25
	if self:FlashlightIsOn() then
		charge = charge - 1
	end
	
	self.suitpower = math.Clamp(self.suitpower + charge,0,100)
	
	if self.suitpower < 1 then
		self:Flashlight( false )
		self:AllowFlashlight( false)
	else
		if self.suitpower > 5 then self:AllowFlashlight( true) end
	end
end

function hl2c_player:SendPower()
	if self.suitpower == self.oldsuitpower then return end	--saves sending same values repeatedly
	net.Start("HL2C_Suit_Power")
		net.WriteFloat( self.suitpower )
	net.Send(self)
	
	self.oldsuitpower = self.suitpower
end

--hook.Add( "PlayerSwitchFlashlight", "SuitFlashLight", function( ply, enabled )
--	net.Start("HL2C_Suit_FlashLight")
--		net.WriteBool( enabled )
--	net.Send(ply)
--end )