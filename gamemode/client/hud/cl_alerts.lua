HL2C_Client.endtime = HL2C_Client.endtime or 0

function HL2C_Client:AlertsDisplay()
	if HL2C_Client.endtime > 0 then
		local timeleft = HL2C_Client.endtime - CurTime()
		if timeleft > 0 then
			local text = string.format("Countdown %02.1f",timeleft)
			draw.SimpleTextOutlined( text, "HUD_Normal", ScrW()*0.02, ScrH()*0.02, Theme.fontwhite,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1,Theme.fontblack )
		else
			draw.SimpleTextOutlined( "Changing Map", "HUD_Normal", ScrW()*0.02, ScrH()*0.02, Theme.fontwhite,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP, 1,Theme.fontblack )
		end
	end

end

hook.Add("HUDPaint", "alerts_hud", function() HL2C_Client:AlertsDisplay() end)

net.Receive( "HL2C_Countdown", function( len )
	HL2C_Client.endtime = net.ReadFloat()
end )