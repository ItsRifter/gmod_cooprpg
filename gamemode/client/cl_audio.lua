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

local SPRINT_SOUND = "player/suit_sprint.wav"
local EXHAUST_SOUND = "common/wpn_denyselect.wav"

local exhaustPressed = exhaustPressed or false

hook.Add("KeyPress", "suit_exhaust", function(player, key)
	if LocalPlayer():Alive() and not LocalPlayer():InVehicle() and key == IN_SPEED and not exhaustPressed then
		if LocalPlayer():GetRunSpeed() < 200 then 
			surface.PlaySound(EXHAUST_SOUND)
			exhaustPressed = true
		else
			if HL2C_Global:NoSuit() then return end
			surface.PlaySound(SPRINT_SOUND)
			exhaustPressed = true
		end
		
	end
		
end)

hook.Add("KeyRelease", "suit_exhaust_release", function(player, key)
	if LocalPlayer():Alive() and not LocalPlayer():InVehicle() and key == IN_SPEED and exhaustPressed then
		exhaustPressed = false
	end
end)