
hook.Add( "ScaleNPCDamage", "Npc_taghitgroup", function( npc, hitgroup, dmginfo )
	npc.LastHitGroup = hitgroup
end )

hook.Add( "EntityTakeDamage", "HL2CR_NPC_TakeDamage", function( target, dmgInfo )
	local attacker = dmgInfo:GetAttacker()

	if attacker:IsVehicle() and attacker:GetDriver() then
		attacker = attacker:GetDriver()
	end
	
    --if ( target:IsFriendly() or target:IsPet() ) and attacker:IsPlayer() then return true end

	--if not Valid_NPC_Targets[target:GetClass()] then return end
	--if not CanPlayerTarget(target:GetClass()) then return end

	--This moves indicator if damage position isnt real
	if dmgInfo:GetDamagePosition():LengthSqr() < 1 then dmgInfo:SetDamagePosition(target:GetPos() + Vector(0,0,64))end
	
    if attacker:IsPlayer() and attacker:IsConnected() then		
		--if not Valid_NPC_Targets[target:GetClass()] then return end
		local damagedone = dmgInfo:GetDamage()
		local dmgtype = dmgInfo:GetDamageType()

		if damagedone > target:Health() then damagedone = target:Health()end
		
		local colour = 1
		if target:GetClass() == "npc_antlion" and game.GetGlobalState("antlion_allied") == GLOBAL_ON then colour = 2 end	--hits turn green if hitting friendly ants
		--antlion_allied
		damagedone = math.Round(damagedone,1)
		if damagedone > 0 then	--prevents erronious negatives
			if colour == 1 then
				--local sucess = attacker:AddDamageExp(tonumber(damagedone),target,dmgtype) 
				local sucess = true
				if target.LastHitGroup and target.LastHitGroup == HITGROUP_HEAD then colour = 9 end
				if !sucess then colour = 8 end	--If damage is block hit turns dark grey
			end
			
			attacker:SendNote(damagedone,dmgInfo:GetDamagePosition(),colour,0)
			
		end
    end
end)