HL2C_Client.suitpower = HL2C_Client.suitpower or 100
HL2C_Client.flashlight = HL2C_Client.flashlight or false


local LIGHT_IDLE, LIGHT_ACTIVE = "®", "©"
local ALPHA_ACTIVE, ALPHA_IDLE = 240, 120
local LIGHT_WIDTH, LIGHT_HEIGHT = math.Round(ScrH() / 12), math.Round(ScrH() / 20)
local LIGHT_X, LIGHT_Y = math.Round(ScrW() * 0.3), math.Round(ScrH() * 0.97 - LIGHT_HEIGHT)
local LIGHT_ALPHA, LIGHT_ALPHAMAX = ALPHA_ACTIVE, 340

surface.CreateFont( "flashlight_font", {
	font = "HalfLife2",
	size = math.Round(ScrH() * 0.07),
	weight = 0,
	additive = true,
	antialias = true
})

function HL2C_Client:DrawBlips(x,y,w,h, amount,value, maximum)
	local offset_x = math.Round(w / amount)
	local width = math.Round(offset_x * 0.80)
	offset_x = offset_x + math.Round((offset_x * 0.20) / (amount-1) )
	local blips = math.Round(amount/maximum*value)
	local red = math.Clamp(200/(amount*0.25)*blips , 100,250)
	local green = math.Clamp(200/amount*blips, 20,150)
	
	for i=0, amount -1 do
		if i < blips then
			draw.RoundedBox(4, x + i*offset_x,y,width,h, Color(red, green, 50, LIGHT_ALPHA))
		else
			draw.RoundedBox(4, x + i*offset_x,y,width,h, Color(40, 20, 10, LIGHT_ALPHA - 60))
		end
	end
end

function HL2C_Client:DrawFlashlight()
	if not IsAlive(LocalPlayer()) then return end

	local icon = LIGHT_IDLE
	
	if (LocalPlayer():FlashlightIsOn()) then 
		icon = LIGHT_ACTIVE 
		LIGHT_ALPHAMAX = 340
		LIGHT_ALPHA = ALPHA_ACTIVE
	else
		if LIGHT_ALPHAMAX > ALPHA_IDLE then LIGHT_ALPHAMAX = LIGHT_ALPHAMAX - FrameTime() * 60 end
		LIGHT_ALPHA = math.Clamp(LIGHT_ALPHAMAX, ALPHA_IDLE,ALPHA_ACTIVE)
	end
	
	draw.RoundedBox(6, LIGHT_X, LIGHT_Y, LIGHT_WIDTH, LIGHT_HEIGHT, Color(0, 0, 0, 80))
	
	HL2C_Client:DrawBlips(LIGHT_X + LIGHT_WIDTH * 0.05,LIGHT_Y + LIGHT_HEIGHT * 0.6,LIGHT_WIDTH * 0.9,LIGHT_HEIGHT * 0.3, 16,HL2C_Client.suitpower, 100)
	
	draw.SimpleText(icon, "flashlight_font", LIGHT_X + LIGHT_WIDTH * 0.5, LIGHT_Y - LIGHT_HEIGHT * 0.5, Color(250, 150, 50, LIGHT_ALPHA), TEXT_ALIGN_CENTER)
end

hook.Add("HUDPaint", "auxpow_flashlight_hud", function() HL2C_Client:DrawFlashlight() end)



net.Receive( "HL2C_Suit_Power", function( len )
	HL2C_Client.suitpower = net.ReadFloat()
end )


hook.Add( "HUDShouldDraw", "HL2C_HideHUD", function( name )
	if ( name == "CHudCrosshair" and HL2C_Client.Config.NewCross ) then
		return false
	end
	
    return true 
end)