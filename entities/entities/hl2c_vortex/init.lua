AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/xqm/rails/trackball_1.mdl")
	--self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetMaterial("Models/effects/comball_tape")
	--self:SetMaterial("Models/effects/comball_sphere")
	self:SetModelScale(0.5)
	self:DrawShadow(false)
	self:SetTrigger(true)
	self:UseTriggerBounds( true,  0 )
end

function ENT:StartTouch(entity)
	if entity:IsValid() then 
		if entity:IsPlayer() and entity:IsTeam(TEAM_HUMAN) and entity:Alive() then
			HL2C_Server:VortexTouched(entity)
		end
	end
end