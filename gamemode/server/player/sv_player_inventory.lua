local hl2c_player = FindMetaTable("Player")

HL2C_Server.AvailableWeapons = {}

HL2C_Server.ForbiddenWeapons = {
    [1] = "weapon_stunstick"
}

HL2C_Server.AdminWeapons = {
    [1] = "weapon_physgun"
}

function hl2c_player:GiveWeapons()
    for _, w in ipairs(HL2C_Server.AvailableWeapons) do
        if !self:HasWeapon( w ) then self:Give(w, true) end
    end
end

function AddWeaponRespawns(strWepClass, bGiveOthers)
    if table.HasValue( HL2C_Server.AvailableWeapons, strWepClass ) then return end
	table.insert(HL2C_Server.AvailableWeapons, strWepClass)

    HL2C_Server:DebugMsg(strWepClass, 0)

    if bGiveOthers then
        for _, p in ipairs(player.GetAll()) do
            if !p:HasWeapon( strWepClass ) then p:Give(strWepClass) end
        end
    end
end

hook.Add("PlayerCanPickupWeapon", "hl2c_inv_weaponcheck", function(ply, wep)
    if table.HasValue(HL2C_Server.ForbiddenWeapons, wep:GetClass()) then return false end
    
    if table.HasValue(HL2C_Server.AdminWeapons, wep:GetClass()) then
        if ply:IsAdmin() then return true
        else return false end
    end

    AddWeaponRespawns(wep:GetClass())
    return true
end)