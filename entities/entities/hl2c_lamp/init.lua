AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.light = false
	self.color_id = 0
	self:DrawShadow( false )
	self:SetModel("models/props_wasteland/light_spotlight02_lamp.mdl")
	self:SetSkin( 1)
end

function ENT:SetColorID(col)
	if self.color_id == col then return end
	self.color_id = col
	self:Update()
end

function ENT:ToggleLamp()
	if not self.light then
		self.light = true
		self:EmitSound( "ambient/energy/newspark03.wav" )
		self:SetSkin( 0)
	else
		self.light = false
		self:EmitSound("ambient/energy/spark2.wav")
		self:SetSkin( 1)
	end
	self:Update()
end

function ENT:Update(ply)
	net.Start( "HL2C_Lamp_Net" )
		net.WriteEntity( self )
		net.WriteBool( self.light )
		net.WriteUInt( self.color_id, 7 )
	if not ply then net.Broadcast() else net.Send(ply) end
end

hook.Add("PlayerInitialSpawn", "HL2C_Sync_lamps", function(ply)
	for k, v in ipairs( ents.FindByClass( "hl2c_lamp" ) ) do
		v:Update(ply)
	end
end)