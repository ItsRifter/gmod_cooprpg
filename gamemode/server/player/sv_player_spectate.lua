local hl2c_player = FindMetaTable("Player")

--TODO--Make it actually spectate stuff

function hl2c_player:ToggleSpectator(shouldEnable)
    if shouldEnable then
        if self:IsValid() then
            self:SetNoTarget(true)
            self:Flashlight(false)
            self:AllowFlashlight(false)
            self:StripWeapons()
            self:Spectate(5)
        end
    else
        self:SetNoTarget(false)
        self:UnSpectate()
        self:UnLock()
    end
end