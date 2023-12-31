translate = {}
local languages = {}
local default = "english"
local selected = default

function translate.translated(id,language)
	if languages[language] then
		if languages[language][id] then return languages[language][id] end
	elseif languages[default]then
		if languages[default][id] then return languages[default][id] end
	end
	return ("@"..id.."@")
end

function translate.Get(id)
	local text = translate.translated(id,selected)
	return text
end

function translate.AddLanguage(name,language)
	languages[name] = language
	if HL2C_Debug then print("Added Translation : "..name) end
end

---------------------------------------------------------------------------------------------------------

for i, filename in pairs(file.Find(GM.FolderName.."/gamemode/shared/language/*.lua", "LUA")) do
	include("language/" .. filename)
	if SERVER then AddCSLuaFile("language/" .. filename) end
end