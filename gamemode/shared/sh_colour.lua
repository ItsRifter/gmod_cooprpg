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

local duocolour = {
	[0] = {A=1,B=2},
	[1] = {A=2,B=3},
	[2] = {A=3,B=1},
	[3] = {A=4,B=5},
	[4] = {A=5,B=6},
	[5] = {A=6,B=4},
	[6] = {A=0,B=8},
	[7] = {A=7,B=2},
	[8] = {A=3,B=9},
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
	elseif number >= 90 and number < 99 then 	--Dual Colours		--WIP, todo or remove if expensive
		local tim = math.Clamp(0.5 + math.sin( CurTime()*4 ) * 0.6,0,1)
		local col_A = colours[0]
		local col_B = colours[0]
		if duocolour[number-90] then
			col_A = colours[duocolour[number-90].A]
			col_B = colours[duocolour[number-90].B]
		end
		
		New = Color(Lerp(tim,col_A.r,col_B.r),Lerp(tim,col_A.g,col_B.g),Lerp(tim,col_A.b,col_B.b),blend) 
	
	elseif number == 99 then 	--Rainbow blend over time
		local add360 = (CurTime() * 180) % 360
		New = HSVToColor( add360, 1, 1 ) 
		New = Color(New.r,New.g,New.b,blend) 
	end

	return New
end