ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self.Triggered = self.Triggered or false
	
	if self.TPPoint:IsZero() then
		HL2C_Server:DebugMsg(string.format("Warp %s has an invalid teleport point", self:GetName()), 1)
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
		if not ent:IsTeam(TEAM_HUMAN_ALIVE) then return end
		ent:RemoveVehicle()
		ent:SetPos(self.TPPoint)
		ent:SetEyeAngles(self.TPAngles)

	end
end
