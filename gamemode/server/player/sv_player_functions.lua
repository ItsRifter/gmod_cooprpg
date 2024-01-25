local hl2c_player = FindMetaTable("Player")

function hl2c_player:FindSurface()
	local tr = util.TraceLine( {
		start = self:GetPos()+ Vector(0,0,32),
		endpos = self:GetPos() + Vector(0,0,512),
		collisiongroup = COLLISION_GROUP_WORLD,
		mask = MASK_SOLID
	} )

	local tr2 = util.TraceLine( {
		start = tr.HitPos- Vector(0,0,8),
		endpos = tr.HitPos - Vector(0,0,512),
		collisiongroup = COLLISION_GROUP_WORLD,
		mask = (MASK_WATER + MASK_SOLID)
	} )

	return tr2.HitPos
end