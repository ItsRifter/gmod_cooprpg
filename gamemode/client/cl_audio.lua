function HL2C_Client:PlaySound(soundPath,setPitch)
	if setPitch then
			sound.Add( {
			name = "hl2c_custom_sound",
			channel = CHAN_STATIC,
			volume = 1.0,
			level = 80,
			pitch = setPitch,
			sound = soundPath
		} )

		LocalPlayer():EmitSound("hl2c_custom_sound")
	else
		surface.PlaySound(soundPath)
	end
end

--I dont know if a timer would be better but this makes client do the work instead of server sending the blips
--plus it can handle the timer being interupted or reset
hook.Add( "Think", "End_Countdown", function()
	if HL2C_Client.endtime > 0 then
		local timeleft = HL2C_Client.endtime - CurTime()
		
		if timeleft < 6 and timeleft >= 0 then
			if not HL2C_Client.endtimeold then HL2C_Client.endtimeold = math.floor(timeleft) end
			if HL2C_Client.endtimeold > math.floor(timeleft) then
				HL2C_Client.endtimeold = math.floor(timeleft)
				HL2C_Client:PlaySound("hl1/fvox/beep.wav",130 - (5*HL2C_Client.endtimeold))
			end
		else
			HL2C_Client.endtimeold = math.floor(timeleft)
		end
	end
end )

