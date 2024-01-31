local hl2c_npc = FindMetaTable( "Entity" )
local hl2c_player = FindMetaTable("Player")

hook.Add( "ScaleNPCDamage", "Npc_taghitgroup", function( npc, hitgroup, dmginfo )
	npc.LastHitGroup = hitgroup
end )

hook.Add("EntityTakeDamage", "HL2C_EntDamage", function(ent, dmgInfo)
	local attacker = dmgInfo:GetAttacker()

	if attacker:IsVehicle() and attacker:GetDriver() then
		attacker = attacker:GetDriver()
	end

    if attacker:IsPlayer() then
        if ent:IsPlayer() and attacker ~= ent then
			if ent:PlayerAttack(dmgInfo,attacker) then return true end
        end
		
		if ent:IsNPC() and ent:PlayerAttack(dmgInfo,attacker) then return true end
    end

    return false
end)