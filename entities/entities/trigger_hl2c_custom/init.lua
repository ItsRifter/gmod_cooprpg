--TODO: Make end level stuff
ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.Triggered = false
ENT.Once = false
ENT.Delay = 0


function ENT:Initialize()
	self.Triggered = self.Triggered or false

	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

--When an entity touches the trigger
function ENT:StartTouch(ent)

	if ent and ent:IsValid() and not self.Triggered then
		self.Triggered = self.Func(ent)
		if self.Triggered and not self.Once then

			if self.Delay <=0 then 
				self.Triggered = false
			else
				timer.Simple( self.Delay, function() 
					self.Triggered = false
				end  )
			end
		end
	end
end