--local hl2c_player = FindMetaTable("Player")

--TODO--Make it actually spectate stuff

function hl2c_player:ToggleSpectator(shouldEnable)
    if shouldEnable then
        if self:IsValid() then
            self:SetNoTarget(true)
            self:Flashlight(false)
            self:AllowFlashlight(false)
            self:StripWeapons()
            self:Spectate(OBS_MODE_CHASE)
        end
    else
        self:SetNoTarget(false)
        self:UnSpectate()
        self:UnLock()
    end
end

function hl2c_player:SpectatePrev()
	local current = self:GetObserverTarget()
	local prev = nil
	
	local list = {}
	if IsHuman(self) then list = HL2C_Global:GetHumans() end
	if IsCombine(self) then list = HL2C_Global:GetCombine() end
	if IsMiscTeam(self) then list = player.GetAll() end
	
	for i, ply in ipairs( list ) do
		if ply != current then
			if IsPlaying(ply) then prev = ply end
		else
			if IsValid(prev) then break end
		end
	end
	
	if IsValid(prev) then self:SpectateEntity( prev ) end

end

function hl2c_player:SpectateNext()
	local current = self:GetObserverTarget()
	local first = nil
	local found = false
	
	local list = {}
	if IsHuman(self) then list = HL2C_Global:GetHumans() end
	if IsCombine(self) then list = HL2C_Global:GetCombine() end
	if IsMiscTeam(self) then list = player.GetAll() end
	
	for i, ply in ipairs( list ) do
		if IsPlaying(ply) and not IsValid(first) then first = ply end
		if ply == current then
			found = true
		else
			if found then first = ply break end
		end
	end
	
	if IsValid(first) then self:SpectateEntity( first ) end

end

hook.Add("KeyPress", "SpecKey", function(ply, key)
	
	if IsPlaying(ply) then return end
	
	if ply:KeyPressed(IN_ATTACK) then
		ply:SpectateNext()
	elseif ply:KeyPressed(IN_ATTACK2) then
		ply:SpectatePrev()
	elseif ply:KeyPressed(IN_JUMP) then
		if ply:GetObserverMode() == OBS_MODE_CHASE then
			ply:Spectate(OBS_MODE_IN_EYE)
		else
			ply:Spectate(OBS_MODE_CHASE)
		end
	end
end)