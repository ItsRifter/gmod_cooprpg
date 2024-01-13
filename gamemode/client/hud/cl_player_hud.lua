HL2C_Client.suitpower = HL2C_Client.suitpower or 100
HL2C_Client.flashlight = HL2C_Client.flashlight or false


local LIGHT_IDLE, LIGHT_ACTIVE = "®", "©"
local ALPHA_ACTIVE, ALPHA_IDLE = 1, 0.18
local LIGHT_WIDTH, LIGHT_HEIGHT = math.Round(ScrH() / 7), math.Round(ScrH() / 13.5)
local LIGHT_X, LIGHT_Y = math.Round(ScrH() * 0.4), math.Round(ScrH() * 0.9)

surface.CreateFont( "flashlight_font", {
	font = "HalfLife2",
	size = math.Round(ScrH() / 12),
	weight = 0,
	additive = true,
	antialias = true
})

function HL2C_Client:DrawBlips(x,y,w,h, amount,value, maximum)
	local offset_x = math.Round(w / amount)
	local width = math.Round(offset_x * 0.80)
	offset_x = offset_x + math.Round((offset_x * 0.20) / (amount-1) )
	--local nudge = x + math.Round(offset_x * 0.1)
	local blips = math.Round(amount/maximum*value)
	for i=0, amount -1 do
		if i < blips then
			draw.RoundedBox(4, x + i*offset_x,y,width,h, Color(250, 150, 50, 160))
		else
			draw.RoundedBox(4, x + i*offset_x,y,width,h, Color(150, 100, 20, 80))
		end
	end
end

function HL2C_Client:DrawFlashlight()
	if not IsAlive(LocalPlayer()) then return end

	local icon = LIGHT_IDLE
	if (LocalPlayer():FlashlightIsOn()) then icon = LIGHT_ACTIVE end
	
	draw.RoundedBox(6, LIGHT_X, LIGHT_Y, LIGHT_WIDTH, LIGHT_HEIGHT, Color(0, 0, 0, 80))
	
	HL2C_Client:DrawBlips(LIGHT_X + LIGHT_WIDTH * 0.05,LIGHT_Y + LIGHT_HEIGHT * 0.15,LIGHT_WIDTH * 0.9,LIGHT_HEIGHT * 0.4, 20,HL2C_Client.suitpower, 100)
	
	draw.SimpleText(icon, "flashlight_font", LIGHT_X + LIGHT_WIDTH * 0.5, LIGHT_Y + LIGHT_HEIGHT * 0.15, Color(250, 150, 50, 200), TEXT_ALIGN_CENTER)
end

hook.Add("HUDPaint", "auxpow_flashlight_hud", function() HL2C_Client:DrawFlashlight() end)



net.Receive( "HL2C_Suit_Power", function( len )
	HL2C_Client.suitpower = net.ReadFloat()
end )