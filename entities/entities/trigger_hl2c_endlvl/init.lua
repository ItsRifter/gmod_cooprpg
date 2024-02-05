--TODO: Make end level stuff
ENT.Base = "base_brush"
ENT.Type = "brush"

--ENT.Triggered = ENT.Triggered or false

function ENT:Initialize()
	self.Triggered = self.Triggered or false

	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

--When the player touches the entity
function ENT:StartTouch(ent)
	if IsValid(ent) then
		if ent:IsPlayer() then
			if not ent:Alive() or not IsHuman(ent) then return end

			HL2C_Server:EndTriggered(self, ent)
			self.Triggered = true
		--elseif ent:GetClass() == "prop_physics" then
		elseif ent:GetModel() then
			HL2C_Server:EndProp(ent)
		end
	end
end