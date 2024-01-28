--Refresh/Open HelpMenu---------------------------------------------------

net.Receive("HL2C_HelpMenu", function()
	HL2C_Client:OpenHelpMenu()
end)

net.Receive("HL2C_ChatMessage", function()
	HL2C_Client:AddChatMessage( net.ReadTable() )
end)
