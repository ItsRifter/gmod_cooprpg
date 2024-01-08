AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hl2c/lamba_logo.mdl")
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetMaterial("hl2c/x64")
	self:DrawShadow( false)
end