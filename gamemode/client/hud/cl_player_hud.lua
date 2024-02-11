HL2C_Client.suitpower = HL2C_Client.suitpower or 100
HL2C_Client.suitstamina = HL2C_Client.suitstamina or 100

local LIGHT_IDLE, LIGHT_ACTIVE = "®", "©"
local ALPHA_ACTIVE, ALPHA_IDLE = 240, 100
local LIGHT_WIDTH, LIGHT_HEIGHT = math.Round(ScrH() / 12), math.Round(ScrH() / 20)
local LIGHT_X, LIGHT_Y = math.Round(ScrW() * 0.3), math.Round(ScrH() * 0.97 - LIGHT_HEIGHT)
local LIGHT_ALPHA, LIGHT_ALPHAMAX = ALPHA_ACTIVE, 340

local STAMINA_WIDTH, STAMINA_HEIGHT = math.Round(ScrH() / 5), math.Round(ScrH() / 24)
local STAMINA_X, STAMINA_Y = math.Round(ScrW() * 0.02), math.Round(ScrH() * 0.85 )
local STAMINA_ALPHA, STAMINA_ALPHAMAX = ALPHA_ACTIVE, 340

surface.CreateFont( "flashlight_font", {
	font = "HalfLife2",
	size = math.Round(ScrH() * 0.07),
	weight = 0,
	additive = true,
	antialias = true
})

local fl_ok = Color(255, 238, 31, 255)
local fl_red = Color(255, 31, 31, 255)


function HL2C_Client:DrawBlips(x,y,w,h, amount,value, maximum,alpha)
	local offset_x = math.Round(w / amount)
	local width = math.Round(offset_x * 0.80)
	offset_x = offset_x + math.Round((offset_x * 0.20) / (amount-1) )
	local blips = math.Round(amount/maximum*value)
	--local red = math.Clamp(200/(amount*0.25)*blips , 100,250)
	--local green = math.Clamp(200/amount*blips, 20,150)
	
	local decay = math.Clamp(4/amount*blips - 1,0,1)
	
	local col = Color(Lerp(decay,fl_red.r,fl_ok.r),Lerp(decay,fl_red.g,fl_ok.g),Lerp(decay,fl_red.b,fl_ok.b),alpha)
	
	for i=0, amount -1 do
		if i < blips then
			draw.RoundedBox(4, x + i*offset_x,y,width,h, Color(col.r, col.g, col.b, alpha))
		else
			draw.RoundedBox(4, x + i*offset_x,y,width,h, Color(40, 20, 10, alpha - 60))
		end
	end
end

-------------------------------------------------------------------------------------

function HL2C_Client:DrawFlashlight()
	if not IsPlaying(LocalPlayer()) then return end

	if HL2C_Global:NoSuit() then return end

	local icon = LIGHT_IDLE
	
	if LocalPlayer():FlashlightIsOn() then 
		icon = LIGHT_ACTIVE
		LIGHT_ALPHAMAX = 340
		LIGHT_ALPHA = ALPHA_ACTIVE
	else
		if LIGHT_ALPHAMAX > ALPHA_IDLE then LIGHT_ALPHAMAX = LIGHT_ALPHAMAX - FrameTime() * 60 end
		LIGHT_ALPHA = math.Clamp(LIGHT_ALPHAMAX, ALPHA_IDLE,ALPHA_ACTIVE)
	end
	
	draw.RoundedBox(6, LIGHT_X, LIGHT_Y, LIGHT_WIDTH, LIGHT_HEIGHT, Color(0, 0, 0, 80))
	
	HL2C_Client:DrawBlips(LIGHT_X + LIGHT_WIDTH * 0.05, LIGHT_Y + LIGHT_HEIGHT * 0.6, LIGHT_WIDTH * 0.9, LIGHT_HEIGHT * 0.3, 
		16, HL2C_Client.suitpower, 100, LIGHT_ALPHA)
	
	draw.SimpleText(icon, "flashlight_font", LIGHT_X + LIGHT_WIDTH * 0.5, LIGHT_Y - LIGHT_HEIGHT * 0.5, 
		Color(255, 238, 31, LIGHT_ALPHA), TEXT_ALIGN_CENTER)
end

function HL2C_Client:DrawStamina()
	if not IsPlaying(LocalPlayer()) then return end

	if HL2C_Global:NoSuit() then return end

	local icon = LIGHT_IDLE
	
	if HL2C_Client.suitstamina < 100 then 
		icon = LIGHT_ACTIVE 
		STAMINA_ALPHAMAX = 340
		STAMINA_ALPHA = ALPHA_ACTIVE
	else
		if STAMINA_ALPHAMAX > 0 then STAMINA_ALPHAMAX = STAMINA_ALPHAMAX - FrameTime() * 60 end
		STAMINA_ALPHA = math.Clamp(STAMINA_ALPHAMAX, ALPHA_IDLE,ALPHA_ACTIVE)
	end
	
	if STAMINA_ALPHAMAX > 0 then
		draw.RoundedBox(6, STAMINA_X, STAMINA_Y, STAMINA_WIDTH, STAMINA_HEIGHT, Color(0, 0, 0, 80))
	
		draw.SimpleText(translate.Get("Basic_Stamina"), "HudDefault", STAMINA_X + STAMINA_WIDTH * 0.05, STAMINA_Y + STAMINA_HEIGHT * 0.1, 
			Color(255, 238, 31, STAMINA_ALPHA), TEXT_ALIGN_LEFT)
	
		HL2C_Client:DrawBlips(STAMINA_X + STAMINA_WIDTH * 0.025,STAMINA_Y + STAMINA_HEIGHT * 0.6, STAMINA_WIDTH * 0.95, STAMINA_HEIGHT * 0.3, 
			10 , HL2C_Client.suitstamina, 100, STAMINA_ALPHA)
	end
	
	--draw.SimpleText(icon, "flashlight_font", LIGHT_X + LIGHT_WIDTH * 0.5, LIGHT_Y - LIGHT_HEIGHT * 0.5, Color(255, 238, 31, LIGHT_ALPHA), TEXT_ALIGN_CENTER)
end

function HL2C_Client:DrawSpectatorInfo()
	if IsPlaying(LocalPlayer()) then return end
	
	local target = LocalPlayer():GetObserverTarget()
	
	if IsValid(target) and target:IsPlayer() then
		draw.SimpleTextOutlined( target:Nick(), "Font_Small", ScrW()*0.5, ScrH()*0.98, Theme.fontwhite,TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM, 1,Theme.fontblack )
	end

end

local oldxp = oldxp or 0
local newxp = newxp or 0
local changed = changed or 0
local xp_alpha = xp_alpha or 0

function HL2C_Client:DrawExperience()
	
	if not IsPlaying(LocalPlayer()) then return end
	
	local xp = LocalPlayer():GetNWInt("hl2c_stat_exp", -1)
	local reqXP = LocalPlayer():GetNWInt("hl2c_stat_expreq", -1)
	
	if reqXP <=0 then return end
	
	local barW = math.floor(ScrW()* 0.3) 
	local barH = math.floor(ScrH()* 0.015) 

	if xp > newxp then
		oldxp = newxp
		newxp = xp
		changed = CurTime()
	elseif xp < newxp then
		oldxp = xp
		newxp = xp
		changed = CurTime()
	end

	local offset = CurTime() - changed

	if offset > 0 then 
		xp_alpha = math.floor(Lerp( offset - 4, 180 , 0))
		
		if !HL2C_Client.Config.HideXP and xp_alpha < 60 then
			xp_alpha = 60
		end
		
	end

	if xp_alpha <= 0 then return end

	local barOld = math.floor(barW / reqXP * oldxp)
	local barNew = math.floor(barW / reqXP * newxp)

	local xpos = math.floor((ScrW()-barW) * 0.5)
	local ypos = math.floor(ScrH() * 0.98)

	draw.RoundedBox( 4, xpos, ypos, barW, barH, Color(0, 0, 0, xp_alpha) )

	
	

	if offset > 2.5 then
		draw.RoundedBox( 4, xpos, ypos, barNew, barH, Color(200, 140, 0, xp_alpha) )
	elseif offset >  1.5 then
		local lerpp = math.floor(Lerp( offset - 1.5, barOld , barNew))
		draw.RoundedBoxEx( 4, xpos, 			ypos, lerpp, barH, Color(200, 140, 0, xp_alpha),true,false,true,false )
		draw.RoundedBoxEx( 4, xpos+lerpp, 	ypos, barNew - lerpp, barH, Color(250, 174, 0, xp_alpha),false,true,false,true  )
	else
		draw.RoundedBoxEx( 4, xpos, 			ypos, barOld, barH, Color(200, 140, 0, xp_alpha),true,false,true,false  )
		draw.RoundedBoxEx( 4, xpos+barOld, 	ypos, Lerp( offset, 0, barNew -barOld), barH, Color(250, 174, 0, xp_alpha),false,true,false,true )
	end


	surface.SetDrawColor( 0, 0, 0, xp_alpha )
	for i=1,7 do 
		local ix = xpos + math.floor(barW * 0.125 * i)
		surface.DrawLine( ix, ypos-2, ix, ypos + barH+4)
		surface.DrawLine( ix+1, ypos-2, ix+1, ypos + barH+4)
	end


end

hook.Add("HUDPaint", "auxpow_flashlight_hud", function() HL2C_Client:DrawFlashlight() end)
hook.Add("HUDPaint", "auxpow_stamina_hud", function() HL2C_Client:DrawStamina() end)
hook.Add("HUDPaint", "spectating_hud", function() HL2C_Client:DrawSpectatorInfo() end)
hook.Add("HUDPaint", "exp_hud", function() HL2C_Client:DrawExperience() end)

-------------------------------------------------------------------------------------

net.Receive( "HL2C_Suit_Power", function( len )
	HL2C_Client.suitpower = net.ReadFloat()
end )

net.Receive( "HL2C_Suit_Stamina", function( len )
	HL2C_Client.suitstamina = net.ReadFloat()
end )

-------------------------------------------------------------------------------------

local Suit_Huds = {
	["CHudSecondaryAmmo"] = true,
	["CHudAmmo"] = true,
	["CHudWeapon"] = true,
	["CHudCrosshair"] = true,
	["CHudWeaponSelection"] = true,
	["CHudHealth"] = true,
}

hook.Add( "HUDShouldDraw", "HL2C_HideHUD", function( name )
	if HL2C_Global:NoSuit() and Suit_Huds[name] then return false end

	if ( name == "CHudCrosshair" and HL2C_Client.Config.NewCross ) then
		return false
	end
	
    return true 
end)