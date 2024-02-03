include("shared.lua")

function ENT:Initialize()
	self.light = false
	self.color = 0
end

function ENT:SpawnLamp()
	local lamp = ProjectedTexture() -- Create a projected texture
	self.lamp = lamp -- Assign it to the entity table so it may be accessed later

	-- Set it all up
	lamp:SetTexture( "effects/flashlight001" )
	lamp:SetFarZ( 1800 ) -- How far the light should shine
	lamp:SetEnableShadows( false )
	lamp:SetNearZ( 16 )
	lamp:SetFOV(  105 )

	lamp:SetPos( self:GetPos() ) -- Initial position and angles
	lamp:SetAngles( self:GetAngles() )
	lamp:Update()
end

--function ENT:Draw()		

	
--end

function ENT:OnRemove()
	if ( IsValid( self.lamp ) ) then
		self.lamp:Remove()
	end
end

function ENT:Think()
	-- Keep updating the light so it's attached to our entity
	-- you might want to call other functions here, you can do animations here as well
	if IsValid( self.lamp ) then 
		if self.color > 80 then self.lamp:SetColor( GetColour(self.color) ) end
		self.lamp:SetPos( self:GetPos() )
		self.lamp:SetAngles( self:GetAngles() )
		self.lamp:Update()
	end
end

function ENT:Update(lit,col)
	self.light = lit
	self.color = col
	
	if lit then
		if not IsValid(self.lamp) then self:SpawnLamp() end
		self.lamp:SetColor( GetColour(self.color) )
	else
		if IsValid(self.lamp) then self.lamp:Remove() end
	end
end

net.Receive( "HL2C_Lamp_Net", function( len )
	local entity = net.ReadEntity()
	local lit = net.ReadBool()
	local col =	net.ReadUInt(7)
	if IsValid(entity) then
		entity:Update(lit,col)
	end
	
end )