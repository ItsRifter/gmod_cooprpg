include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	
	if not self.core then self:Init() end
end

function ENT:Init()
	--VortexBall = ents.Create("prop_dynamic")
	--self.core = ents.Create("prop_dynamic")
	self.core = ents.CreateClientProp()
    --self.core:SetModel("models/effects/combineball.mdl")
	self.core:SetModel("models/hunter/misc/sphere025x025.mdl")
	
	--self.core:SetMaterial( "models/props_combine/portalball001_sheet")
	self.core:SetMaterial( "Models/effects/comball_sphere")
	--self.core:SetMaterial( "Models/effects/comball_tape")
	
	
	
    self.core:SetPos(self:GetPos())
    self.core:Spawn()
	self.core:SetModelScale(0.75)

	self.core:StartLoopingSound( "weapons/physcannon/superphys_hold_loop.wav" )
end
