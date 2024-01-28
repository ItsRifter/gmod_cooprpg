local hl2c_player = FindMetaTable("Player")

HL2C_Server.AvailableWeapons = HL2C_Server.AvailableWeapons or {}

HL2C_Server.ForbiddenWeapons = {
    [1] = "weapon_stunstick"
}

HL2C_Server.AdminWeapons = {
    [1] = "weapon_physgun",
	[2] = "weapon_hl2c_boxmarker"
}

function HL2C_Server:SetupWeapons()
	if HL2C_Map.Weapons then
		HL2C_Server.AvailableWeapons = table.Copy(HL2C_Map.Weapons)
	else
		HL2C_Server.AvailableWeapons = {}
	end
end


function hl2c_player:GiveWeapons()
	--PrintTable(HL2C_Server.AvailableWeapons)
    for _, w in ipairs(HL2C_Server.AvailableWeapons) do
        if !self:HasWeapon( w ) then self:Give(w, false) end
    end
end

--Prevents a endless supply of new weapons to players	--should be fixed now
--local suppress_NewWeapons = false

function AddWeaponRespawns(strWepClass, ply)
    if not table.HasValue( HL2C_Server.AvailableWeapons, strWepClass ) then 
	    table.insert(HL2C_Server.AvailableWeapons, strWepClass)

        for _, p in ipairs(player.GetAll()) do
			if not p:IsTeam(TEAM_HUMAN) or p == ply then continue end
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

    AddWeaponRespawns(wep:GetClass(),ply)

    return true
end)

function hl2c_player:GiveLoadout()
	if not HL2C_Map.Loadout then return end
	
    for k, v in pairs(HL2C_Map.Loadout) do
        if k == "armour" then self:SetArmor(v) continue end
		if k == "A357" then self:SetAmmo( v, "357") continue end	--fixes stupid ammo name being a number
		if game.GetAmmoID( k ) >= 0 then
			self:SetAmmo( v, k )
		end
    end
end