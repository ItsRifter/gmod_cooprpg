--TODO: Make checkpoint stuff

ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPPoint = ENT.TPPoint or Vector(0, 0, 0)
ENT.TPAngles = ENT.TPAngles or Angle(0, 0, 0)
ENT.Mat = "hl2cr/models/checkpoint.vtf"
ENT.Triggered = ENT.Triggered or false

function ENT:Initialize()
	
	if self.TPPoint == Vector(0, 0, 0) then
		print("CHECKPOINT FAIL: VECTOR INVALID")
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

	--if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.Triggered then
	if ent and ent:IsValid() and ent:IsPlayer() then
		self.Triggered = true
		
		--if self.Func then
		--	self.Func()
		--end

		--BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_Checkpoint"))

		--MoveSpawns(self.TPPoint,self.TPAngles)

		--MovePlayers(self.TPPoint,self.TPAngles, true, ent)
		
		--if false then --debug for checkpoint verifying in solo
		--	GAMEMODE:RemoveVehicle(ent)
		--	
		--	ent:SetPos(self.TPPoint)
		--	ent:SetEyeAngles(self.TPAngles)
		--end
			
		ent:SetPos(self.TPPoint)
		ent:SetEyeAngles(self.TPAngles)
		ent:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		--self.lambdaModel:Remove()
	end

end

function ENT:IsTriggered()
	return self.Triggered
end