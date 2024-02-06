HL2C_Client.endtime = HL2C_Client.endtime or 0
HL2C_Client.vehicle = HL2C_Client.vehicle or VEHC_NONE

HL2C_Client.vehc_info = HL2C_Client.vehc_info or nil

function HL2C_Client:AlertsDisplay()
	if HL2C_Client.endtime > 0 then
		local timeleft = HL2C_Client.endtime - CurTime()
		local col = Theme.fontwhite
		local text2 = translate.Get("GM_ChangingMap")
		
		if HL2C_Global:MapFailed() then 
			col = Theme.fontred 
			text2 = translate.Get("GM_RestartingMap")
		end
		
		if timeleft > 0 then
			local text = string.format("Countdown %02.1f",timeleft)
			draw.SimpleTextOutlined( text, "HUD_Normal", ScrW()*0.02, ScrH()*0.03, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1,Theme.fontblack )
		else
			draw.SimpleTextOutlined( text2, "HUD_Normal", ScrW()*0.02, ScrH()*0.03, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1,Theme.fontblack )
		end
	end

	if HL2C_Client.vehc_info then
		local text = translate.Get("Vehicle_ToSpawn")..translate.Get(HL2C_Client.vehc_info.Name)
		draw.SimpleTextOutlined( text, "HUD_Small", ScrW()*0.01, ScrH()*0.01, Theme.fontgreen,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1,Theme.fontblack )
	end
	
	if HL2C_Global:MapVortex() then
		local text = translate.Get("GM_Vortex")
		draw.SimpleTextOutlined( text, "HUD_Small", ScrW()*0.99, ScrH()*0.01, Theme.fontyel,TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP, 1,Theme.fontblack )
	end
	
end

hook.Add("HUDPaint", "alerts_hud", function() HL2C_Client:AlertsDisplay() end)

net.Receive( "HL2C_Countdown", function( len )
	HL2C_Client.endtime = net.ReadFloat()
end )

net.Receive( "HL2C_Vehicle", function( len )
	HL2C_Client.vehicle = net.ReadUInt(4)
	HL2C_Client.vehc_info = HL2C_Global:GetVehicleInfo(HL2C_Client.vehicle)
end )