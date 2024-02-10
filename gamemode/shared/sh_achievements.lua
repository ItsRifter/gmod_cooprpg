HL2C_Ach = HL2C_Ach or {}
HL2C_Ach.achievements = HL2C_Ach.achievements or {}

local superlist = {}

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

function HL2C_Ach:GetAchievement(id,group)
	if not group then 
		if not superlist[id] then return nil end
		group = superlist[id]
	end
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

for k, v in pairs(HL2C_Ach.achievements) do
	for kk, vv in pairs(v.Achievements) do
		if not superlist[kk] then
			superlist[kk] = k
		else
			print("WARNING, DUPLICATE ACHIEVEMENT ID")
			print(kk)
		end
	end
	--PrintTable(superlist)
end

function HL2C_Ach:GetAllAchievements()
	return superlist
end