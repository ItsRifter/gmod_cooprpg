local hl2c_npc = FindMetaTable( "Entity" )

local FRIENDLY_NPCS = {
	["npc_kleiner"] = true,
	["npc_dog"] = true,
	["npc_eli"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	["npc_fisherman"] = true,
	["npc_mossman"] = true,
	["npc_gman"] = true,
	["npc_breen"] = true
}

local FRIENDLY_HARMABLE_NPCS = { 
	["npc_citizen"] = true,
	["npc_alyx"] = true,
	["npc_monk"] = true,
	["npc_barney"] = true,
}

local COMBINE_HARMABLE_NPCS = {
    ["npc_cscanner"] = true,
    ["npc_metropolice"] = true,
    ["npc_manhack"] = true,
    ["npc_combine_s"] = true,
    ["npc_turret_ground"] = true,
	["npc_hunter"] = true,
    ["npc_turret_floor"] = true,
    ["combine_mine"] = true,
}

function hl2c_npc:IsProtected()

	if FRIENDLY_NPCS[self:GetClass()] then
		return true
	end
	
	--if self:GetClass() == "npc_vortigaunt" and !MAPS_VORT_HOSTILE[game.GetMap()] then
	if self:GetClass() == "npc_vortigaunt" then
		return true 
	end
	
	
	
	--if FORCE_FRIENDLY_MAPS[game.GetMap()] then
	--	for _, force in ipairs(FORCE_FRIENDLY_MAPS[game.GetMap()]) do
	--		if force == self:GetClass() then
	--			return true
	--		end
	--	end
	--end


    return false
end

function hl2c_npc:IsHumanTeam()
	if FRIENDLY_HARMABLE_NPCS[self:GetClass()] then
		return true
	end
	if self:GetClass() == "npc_antlion" and game.GetGlobalState("antlion_allied") == GLOBAL_ON then return true end
	return false
end

function hl2c_npc:IsCombineTeam()
	if COMBINE_HARMABLE_NPCS[self:GetClass()] then
		return true
	end
	return false
end


function hl2c_npc:PlayerAttack(dmgInfo,ply)
--hook.Add( "EntityTakeDamage", "HL2CR_NPC_TakeDamage", function( target, dmgInfo )
	--local attacker = dmgInfo:GetAttacker()

	--if attacker:IsVehicle() and attacker:GetDriver() then
	--	attacker = attacker:GetDriver()
	--end
	
    if ( self:IsProtected() )  then return true end
	
	if (IsHuman(ply) and self:IsHumanTeam()) then return true end
	if (IsCombine(ply) and self:IsCombineTeam()) then return true end

	--if not Valid_NPC_Targets[target:GetClass()] then return end
	--if not CanPlayerTarget(target:GetClass()) then return end

	--This moves indicator if damage position isnt real
	
    if ply:IsConnected() then		
		if dmgInfo:GetDamagePosition():LengthSqr() < 1 then dmgInfo:SetDamagePosition(self:GetPos() + Vector(0,0,64))end
		--if not Valid_NPC_Targets[target:GetClass()] then return end
		local damagedone = dmgInfo:GetDamage()
		local dmgtype = dmgInfo:GetDamageType()

		if damagedone > self:Health() then damagedone = self:Health()end
		
		local colour = 1
		if self:GetClass() == "npc_antlion" and game.GetGlobalState("antlion_allied") == GLOBAL_ON then colour = 2 end	--hits turn green if hitting friendly ants
		--antlion_allied
		damagedone = math.Round(damagedone,1)
		if damagedone > 0 then	--prevents erronious negatives
			if colour == 1 then
				local sucess = ply:AddDamageExp(tonumber(damagedone),self,dmgtype) 
				--local sucess = true
				if self.LastHitGroup and self.LastHitGroup == HITGROUP_HEAD then colour = 9 end
				if !sucess then colour = 8 end	--If damage is block hit turns dark grey
			end
			
			ply:SendNote(damagedone,dmgInfo:GetDamagePosition(),colour,0)
			
		end
    end
	
	return false
end
--end)

hook.Add("OnEntityCreated", "HL2C_OnNPCCreation", function(ent)
	--if ent:IsNPC() then
	--	for i, ply in ipairs( player.GetAll() ) do
	--		ent:UpdatePlayerRelations(ply)
	--	end	
	--end
end)

function hl2c_npc:UpdatePlayerRelations(ply)	--NEEDS TESTING, PROBABLY MESSES THINGS UP

	if true then return end	--It does, fuck it for now
	
	--Feels like combine players will need their own player type so they dont get the same treatment as players do by enemies
	
	if self:IsHumanTeam() then
		if IsHuman(ply) then self:AddEntityRelationship(ply,D_NU,50) 
		else self:AddEntityRelationship(ply,D_HT,50) end
	elseif self:IsCombineTeam() then
		if IsCombine(ply) then self:AddEntityRelationship(ply,D_NU,50) 
		else self:AddEntityRelationship(ply,D_HT,50) end
	end
end

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
	for i, v in ipairs( HL2C_Global:GetHumans() ) do	
		if v:IsAlive() then
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