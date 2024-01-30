HL2R_TEXT_RED 		= Color(200, 20, 20)
HL2R_TEXT_GREEN 	= Color(25, 200, 25)
HL2R_TEXT_ORANGE 	= Color(250, 150, 50)
HL2R_TEXT_NORMAL 	= Color(255, 200, 180)

--HL2CR_StandardColour = Color(255, 120, 0)
--HL2CR_PlayerColour = Color(255, 200, 50)
--HL2CR_LevelupColour = Color(255, 195, 0)
--HL2CR_LevelColour = Color(255, 145, 0)
--HL2CR_WarningColour = Color(235, 235, 0)
--HL2CR_GreenColour = Color(25, 200, 25)
--HL2CR_RedColour = Color(200, 20, 20)
--HL2CR_AchNotifyColour = Color(255, 200, 125)

local colours = {
	[0] = Color(255, 255, 255),		--White
	[1] = Color(255, 020, 20),		--Red
	[2] = Color(20, 255, 20),		--Green
	[3] = Color(20, 20, 255),		--Blue
	[4] = Color(255, 255, 20),		--Yellow
	[5] = Color(255, 20, 255),		--Magenta
	[6] = Color(20, 255, 255),		--Cyan
	[7] = Color(160, 20, 160),		--Purple
	[8] = Color(50, 50, 50),		--DarkGrey
	[9] = Color(220, 130, 5)		--Orange
}

function GetColour(number, blend)
	local New = colours[0]	--Default White
	if colours[number] then New = colours[number] end

	New.a = blend or 255
	
	if number >= 80 and number <= 89 then 	--Pulse Colours
		local add360 = 0.5 + math.abs(Lerp(CurTime()%1.5,-0.5,0.5))
		hue, sat, val = ColorToHSV( colours[number - 80] )
		New = HSVToColor( hue, sat, val * add360 ) 
		New = Color(New.r,New.g,New.b,blend) 
	elseif number >= 90 and number <= 99 then 	--Dual Colours		--WIP, todo or remove if expensive
		local tim = math.Clamp(0.5 + math.sin( (CurTime()*4) % 360 ) * 0.6,0,1)
		local col_A = colours[0]
		local col_B = colours[0]
		if number == 90 then col_A = colours[1] col_B = colours[3] end	--red/blue
		if number == 91 then col_A = colours[1] col_B = colours[2] end	--red/green
		if number == 92 then col_A = colours[2] col_B = colours[3] end	--green/blue
		
		if number == 97 then col_A = colours[7] col_B = colours[2] end	--purple/green
		if number == 98 then col_A = colours[3] col_B = colours[9] end	--blue/orange
		
		New = Color(Lerp(tim,col_A.r,col_B.r),Lerp(tim,col_A.g,col_B.g),Lerp(tim,col_A.b,col_B.b),blend) 
	
	elseif number == 99 then 	--Rainbow blend over time
		local add360 = (CurTime() * 180) % 360
		New = HSVToColor( add360, 1, 1 ) 
		New = Color(New.r,New.g,New.b,blend) 
	end

	return New
end