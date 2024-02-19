--Table data will be empty for a while, its just a list of possible skills we could add
HL2C_Skills = HL2C_Skills or {}

HL2C_Skills.skills = {
	["hpboost_1"]={			--Increase HP slightly
		onspawn = function(ply)	ply:AddMaxHealth(10) end,
	},
	["hpboost_2"]={			--Increase HP slightly
		onspawn = function(ply)	ply:AddMaxHealth(10) end,
		required = {"hpboost_1"},
	},
	["hpboost_3"]={			--Increase HP slightly
		onspawn = function(ply)	ply:AddMaxHealth(10) end,
		required = {"hpboost_2"},
	},
	["armor_1"]={			--Increase Armour slightly
		onspawn = function(ply)	ply:AddMaxArmour(10) end,
	},
	["armor_2"]={			--Increase Armour slightly
		onspawn = function(ply)	ply:AddMaxArmour(10) end,
		required = {"armor_1"},
	},
	["armor_3"]={			--Increase Armour slightly
		onspawn = function(ply)	ply:AddMaxArmour(10) end,
		required = {"armor_2"},
	},
	["flashdrain_1"]={		--Decrease flashlight drain
		onspawn = function(ply)	ply:AddFlashDrain(-0.15)end,
	},
	["flashdrain_2"]={		--Decrease flashlight drain
		onspawn = function(ply)	ply:AddFlashDrain(-0.15)end,
		required = {"flashdrain_1"},
	},
	["Ammo_1"]={			--Prevent wasted ammo
	},
	["Ammo_2"]={			--Extra carry clip
		required = {"Ammo_1"},
	},
	["Ammo_3"]={			--Start map prepared
		required = {"Ammo_2"},
	},
	["sprintdrain"]={		--Decrease Sprintdrain
	},
	["sprintrecover"]={		--Recover sprint earlier
	},
	["regenstamina"]={		--Increase stamina regen
	},
	["regenbattery"]={		--Increase battery regen
	},
	["regenhealth_1"]={		--Give health regen
	},
	["regenhealth_2"]={		--Give more health regen
	},
	["loadout_1"]={			--Unlock setting different melee weapon?			give a starting one?
	},
	["loadout_2"]={			--Unlock setting different bullet weapons?			give a starting one?
	},
	["vehicle_1"]={			--Unlock setting custom lamp colours on vehicle?	give a few starting ones?
	},
	["vehicle_2"]={			--Unlock setting custom colour/skin on vehicle?		give a starting one?
	},
}

function HL2C_Skills:GetSkill(skill)
	if HL2C_Skills.skills[skill] then return HL2C_Skills.skills[skill] end
	return nil
end