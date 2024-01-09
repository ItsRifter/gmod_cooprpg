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
	--if self.Triggered then return end
	--if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.Triggered then
	if ent and ent:IsValid() and ent:IsPlayer() then
		if ent:Team() != TEAM_HUMAN_ALIVE then return end
		HL2C_Server:EndTriggered(self,ent)
		self.Triggered = true
		--ent:SetTeam(TEAM_HUMAN_FIN)
		--ent:EmitSound("vo/k_lab/kl_excellent.wav", 100, 100)
	end
end