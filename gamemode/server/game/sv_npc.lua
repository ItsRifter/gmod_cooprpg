
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

function HL2C_Server:CreateEnemy(class,pos,angle,weapon, search)
	local enemy = ents.Create(class)
	enemy:SetPos(pos)
	enemy:SetAngles(angle)
	if weapon then enemy:Give( weapon ) end
	enemy:Spawn()
	
	if !search then return end
	
	local target = nil
	local distance = 1000
	local enemypos = enemy:GetPos()
	
	local positions = {}	--creating list of alive player positions
	for i, v in ipairs( player.GetAll() ) do	
		if v:IsTeam(TEAM_HUMAN) then
			table.insert( positions, v )
		end
	end
	
	for i, v in ipairs( positions ) do	
		local toplayer = enemypos:Distance(v:GetPos())
		if toplayer > 50 and toplayer < distance then
			target = v
			distance = toplayer
		end
	end
	
	if IsValid(target) then
		enemy:SetEnemy( target , true)
		enemy:UpdateEnemyMemory( target, target:GetPos())
		enemy:SetActivity(11)
		enemy:SetArrivalDistance(128)
	end
	
end