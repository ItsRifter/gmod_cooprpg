--TODO: Make checkpoint stuff

ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self.Triggered = self.Triggered or false
	
	if self.TPPoint:IsZero() then
		HL2C_Server:DebugMsg(string.format("Checkpoint %s has an invalid teleport point", self:GetName()), 1)
		return
	end

	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

--When the player touches the entity
function ENT:StartTouch(ent)
	if self.Triggered then return end

	if ent and ent:IsValid() and ent:IsPlayer() then
		if not ent:Alive() then return end
		
		HL2C_Server:CheckpointTriggered(self,ent)
		self.Triggered = true

	end
end
