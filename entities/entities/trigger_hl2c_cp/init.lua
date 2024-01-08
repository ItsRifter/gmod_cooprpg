--TODO: Make checkpoint stuff

ENT.Base = "base_brush"
ENT.Type = "brush"

--ENT.TPPoint = ENT.TPPoint or Vector(0, 0, 0)
--ENT.TPAngles = ENT.TPAngles or Angle(0, 0, 0)
--ENT.Mat = "hl2cr/models/checkpoint.vtf"
--ENT.Triggered = ENT.Triggered or false

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
	
	self:SetMaterial(self.Mat)
end

--When the player touches the entity
function ENT:StartTouch(ent)
	if self.Triggered then return end
	--if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.Triggered then
	if ent and ent:IsValid() and ent:IsPlayer() then
		if ent:Team() != TEAM_HUMAN_ALIVE then return end
		self.Triggered = true
		
		--HL2C_Server:MoveSpawn(self.TPPoint, self.TPAngles, nil)
		
		--if self.lambda then self.lambda:Remove() end
		
		HL2C_Server:CPTriggered(self,ent)
		
		--ent:SetPos(self.TPPoint)
		--ent:SetEyeAngles(self.TPAngles)
		--ent:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		--self.lambdaModel:Remove()
	end

end
