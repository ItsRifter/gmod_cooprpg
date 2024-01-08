include("shared.lua")

function ENT:Draw()
	self:DrawEntityOutline()
	self:DrawModel()
end

function ENT:Think()
	self:SetAngles(Angle(0,CurTime()*-120,0))
end

local matOutlineBlack 	= Material( "black_outline" )

function ENT:DrawEntityOutline( size )
	
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
		--Outline	
		render.MaterialOverride( matOutlineBlack )
		self:SetModelScale( 1.05)
		self:DrawModel()
		self:SetModelScale( 0.95)
		self:DrawModel()
		
		--Revert everything back to how it should be
		render.MaterialOverride( nil )
		self:SetModelScale( 1 )
		
	render.SuppressEngineLighting( false )
	
	local r, g, b = self:GetColor():Unpack()
	render.SetColorModulation( r/255, g/255, b/255 )

end