--Client to Server
util.AddNetworkString("HL2C_Model_Update")

--Server to Client--
util.AddNetworkString("HL2C_HelpMenu")				--Tells client to open help menu

util.AddNetworkString("HL2C_Countdown")	

util.AddNetworkString("HL2C_Indicator")
util.AddNetworkString("HL2C_PlaySnd")

util.AddNetworkString("HL2C_ChatMessage")

util.AddNetworkString("HL2C_Vehicle")
util.AddNetworkString("HL2C_Lamp_Net")

util.AddNetworkString("HL2C_AchievementSend")	--Send achieved list
util.AddNetworkString("HL2C_AchievementProg")	--Send progression list
util.AddNetworkString("HL2C_AchievementEarned")	--Send new earned
util.AddNetworkString("HL2C_AchievementUpdate")	--Send new update

--Global vars
util.AddNetworkString("HL2C_GV_NOSUIT")
util.AddNetworkString("HL2C_GV_MAPFAILED")
util.AddNetworkString("HL2C_GV_MAPWON")
util.AddNetworkString("HL2C_GV_VORTEX")

--util.AddNetworkString("HL2C_Suit_FlashLight")	
util.AddNetworkString("HL2C_Suit_Power")
util.AddNetworkString("HL2C_Suit_Stamina")		

--Dev Commands
util.AddNetworkString("HL2C_DEV_AddCP")	
util.AddNetworkString("HL2C_DEV_DestroyCPs")

util.AddNetworkString("HL2C_Admin_Data_DoWipe")
util.AddNetworkString("HL2C_Admin_Achievement_Give")