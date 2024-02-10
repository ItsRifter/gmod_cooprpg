HL2C_Ach = HL2C_Ach or {}
HL2C_Ach.achievements = HL2C_Ach.achievements or {}

-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

function HL2C_Ach:AddAchievementSet(name,data)
	HL2C_Ach.achievements[name] = data
end


function HL2C_Ach:GetGroups()
	return SortedPairsByMemberValue(HL2C_Ach.achievements, "Index", false)
end

function HL2C_Ach:GetGroupAchievements(group)
	if not HL2C_Ach.achievements[group] then return nil end
	return SortedPairsByMemberValue(HL2C_Ach.achievements[group].Achievements, "Index", false)
end

function HL2C_Ach:GetAchievement(group,id)
	if not HL2C_Ach.achievements[group] then return nil end
	if not HL2C_Ach.achievements[group].Achievements[id] then return nil end
	return HL2C_Ach.achievements[group].Achievements[id]
end

-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

for i, filename in pairs(file.Find(GM.FolderName.."/gamemode/shared/achievements/*.lua", "LUA")) do
	AddCSLuaFile("achievements/" .. filename)
	include("achievements/" .. filename)
end