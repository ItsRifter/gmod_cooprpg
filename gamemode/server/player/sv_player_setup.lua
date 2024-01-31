local hl2c_player = FindMetaTable("Player")

function hl2c_player:DoSpawn()
    if self:Team() == TEAM_UNASSIGNED then 
        self:SetTeam(TEAM_HUMAN)
        self:SetNWBool("HL2C_Player_MapFin", false)
    end
    
    local plyModel = string.format("models/player/Group01/male_0%s.mdl", tostring(math.random(1, 7)))
    self:SetModel(plyModel)

	self:SetupSuit()
	
    self:SetNoCollideWithTeammates(true)
    self:GiveWeapons()
	self:GiveLoadout()

    
end

hook.Add("PlayerSpawn", "HL2C_Player_Spawn", function(ply, transition)
    ply:DoSpawn()
end)

--Called right after GM:DoPlayerDeath, GM:PlayerDeath and GM:PlayerSilentDeath.
function hl2c_player:PostDeath()
    if self:FlashlightIsOn() then self:Flashlight( false ) end
end

hook.Add("PostPlayerDeath", "HL2C_Player_PostDeath", function(ply, transition)
    ply:PostDeath()
end)


function hl2c_player:PlayerAttack(dmgInfo,ply)
	if self:Team() == ply:Team() then return true end
	
    if ply:IsConnected() then		
		if dmgInfo:GetDamagePosition():LengthSqr() < 1 then dmgInfo:SetDamagePosition(target:GetPos() + Vector(0,0,64))end
		--if not Valid_NPC_Targets[target:GetClass()] then return end
		local damagedone = dmgInfo:GetDamage()
		local dmgtype = dmgInfo:GetDamageType()

		if damagedone > self:Health() then damagedone = self:Health()end
		
		local colour = 1
		--antlion_allied
		damagedone = math.Round(damagedone,1)
		if damagedone > 0 then	--prevents erronious negatives
			if colour == 1 then
				--local sucess = attacker:AddDamageExp(tonumber(damagedone),target,dmgtype) 
				local sucess = true
				if self.LastHitGroup and self.LastHitGroup == HITGROUP_HEAD then colour = 9 end
				if !sucess then colour = 8 end	--If damage is block hit turns dark grey
			end
			
			ply:SendNote(damagedone,dmgInfo:GetDamagePosition(),colour,0)
			
		end
    end
	
	return false
end