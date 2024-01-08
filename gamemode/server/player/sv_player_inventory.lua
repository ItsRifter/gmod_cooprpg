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

--Prevents a endless supply of new weapons to players
local suppress_NewWeapons = false

function AddWeaponRespawns(strWepClass, bGiveOthers)
    if not table.HasValue( HL2C_Server.AvailableWeapons, strWepClass ) then 
	    table.insert(HL2C_Server.AvailableWeapons, strWepClass)
        bGiveOthers = true
    end
    //HL2C_Server:DebugMsg(strWepClass, 0)
    if bGiveOthers then
        suppress_NewWeapons = true
        for _, p in ipairs(player.GetAll()) do
            if !p:HasWeapon( strWepClass ) then p:Give(strWepClass) end
        end
        suppress_NewWeapons = false
    end
end

hook.Add("PlayerCanPickupWeapon", "hl2c_inv_weaponcheck", function(ply, wep)
    if table.HasValue(HL2C_Server.ForbiddenWeapons, wep:GetClass()) then return false end
    
    if table.HasValue(HL2C_Server.AdminWeapons, wep:GetClass()) then
        if ply:IsAdmin() then return true
        else return false end
    end

    if not suppress_NewWeapons then
        AddWeaponRespawns(wep:GetClass())
    end

    return true
end)