AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/xqm/rails/trackball_1.mdl")
	--self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetMaterial("Models/effects/comball_tape")
	--self:SetMaterial("Models/effects/comball_sphere")
	self:DrawShadow( false)
	self:SetTrigger( true)
	self:UseTriggerBounds( true,  0 )
end

function ENT:StartTouch(entity )
	if entity:IsValid() and entity:IsPlayer() and IsHuman(entity) then
		entity:EmitSound("ambient/levels/prison/radio_random11.wav")
	end
end