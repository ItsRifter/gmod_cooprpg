AddCSLuaFile()

GM.Name = "Half-Life 2: Co-Op Synergized"
GM.Author = "ItsRifter"
GM.Email = "dontspam_me@goaway.com"
GM.Website = "N/A"

GM.ServerName = GetHostName()

HL2C_Global = HL2C_Global or {}

if SERVER then
    HL2C_Server = HL2C_Server or {}
end

if CLIENT then
    HL2C_Client = HL2C_Client or {}
end