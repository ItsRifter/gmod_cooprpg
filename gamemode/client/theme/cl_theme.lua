local panel_meta = FindMetaTable( "PANEL" )

	surface.CreateFont( "HUD_Normal", 
		{
		font    = "Impact",
		size    = ScrH() * 0.035,
		weight  = 100,
		antialias = true,
		})
		
	surface.CreateFont( "HUD_Small", 
		{
		font    = "Impact",
		size    = ScrH() * 0.025,
		weight  = 100,
		antialias = true,
		})


function HL2C_Client:CreateFonts()
	print("creating font sets")
	local fontscale = ScrH() * HL2C_Client:Get_UIScale()
	surface.CreateFont( "Font_Normal", 
		{
		font    = "Impact",
		size    = fontscale * 0.035,
		weight  = 100,
		antialias = true,
		})
		
	surface.CreateFont( "Font_Small", 
		{
		font    = "Impact",
		size    = fontscale * 0.03,
		weight  = 100,
		antialias = true,
		})
		
	surface.CreateFont( "Font_Tiny", 
		{
		font    = "Impact",
		size    = fontscale * 0.025,
		weight  = 100,
		antialias = true,
		})
		
	surface.CreateFont( "Font2_Small", 
		{
		font    = "DejaVu Sans",
		size    = fontscale * 0.028,
		weight  = 100,
		antialias = true,
		})
	surface.CreateFont( "Font2_Tiny", 
		{
		font    = "DejaVu Sans",
		size    = fontscale * 0.024,
		weight  = 100,
		antialias = true,
		})
	surface.CreateFont( "Font2_Micro", 
		{
		font    = "DejaVu Sans",
		size    = fontscale * 0.020,
		weight  = 100,
		antialias = true,
		})
end	
HL2C_Client:CreateFonts()

Theme = {
	col = Color( 240, 140, 50, 255 ),
	backcol = Color( 255, 140, 20, 80 ),
	backcol2 = Color( 255, 140, 20, 35 ),
	backcol3 = Color( 10, 10, 10, 60 ),
	backcol4 = Color( 10, 10, 10, 160 ),
	fontcol = Color( 200, 200, 200, 255 ),
	fontcolhi = Color( 250, 250, 250, 255 ),
	fontcolout = Color( 20, 20, 20, 255 ),
	fontred = Color( 220, 50, 50, 255 ),
	fontgreen = Color( 50, 200, 50, 255 ),
	fontyel = Color( 200, 200, 50, 255 ),
	fontwhite = Color( 220, 220, 220, 255 ),
	fontblack = Color( 20, 20, 20, 255 ),
	button = Color( 255, 140, 0, 255 ),
	buttonhi = Color( 255, 170, 50, 255 ),
	buttonout = Color( 10, 10, 10, 255 ),
	buttonouthi = Color( 240, 240, 240, 255 ),
	box = Color( 220, 110, 0, 255 ),
	box2 = Color( 180, 100, 0, 255 ),
	box3 = Color( 220, 110, 0, 100 ),
	box4 = Color( 180, 100, 0, 100 ),
	secret1 = Color( 240, 200, 0, 255 ),
	secret2 = Color( 200, 180, 0, 100 ),
	barback = Color( 120, 60, 5, 180 ),
	skill_0 = Color( 50,  50, 50, 220 ),
	skill_1 = Color( 180, 60, 50, 220 ),
	skill_2 = Color( 100, 250, 100, 220 ),
}


local tex_tick = Material( "icon16/tick.png", "noclamp smooth" )
local tex_cross = Material( "icon16/cross.png", "noclamp smooth" )
local tex_cog = Material( "icon16/cog.png", "noclamp smooth" )

local tex_games = {
	[220] = Material( "games/16/hl2.png", "noclamp smooth" ),
	[240] = Material( "games/16/cstrike.png", "noclamp smooth" ),
	[380] = Material( "games/16/episodic.png", "noclamp smooth" ),
	[420] = Material( "games/16/ep2.png", "noclamp smooth" ),
	[340] = Material( "games/16/lostcoast.png", "noclamp smooth" ),
	[251110] = Material( "games/16/infra.png", "noclamp smooth" ),
}

local str_games = {
	[220] = "Half-Life 2" ,
	[240] = "Counter Strike Source",
	[380] = "Episode 1" ,
	[420] = "Episode 2" ,
	[340] = "Lost Coast" ,
	[251110] = "Infra" ,
}

local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
end

function PANEL:SetGame(depot,value)
	if tex_games[depot]then
		self:SetMaterial(tex_games[depot])
		self:SetTooltip(str_games[depot] )
		if value >= 2 then self:SetColor(Color(255, 255, 255, 255)) 
		elseif value == 1 then self:SetColor(Color(80, 80, 80, 255))
		else self:SetColor(Color(0, 0, 0, 150)) end
	end
end
vgui.Register( "ThemeGameIcon", PANEL, "DImageButton" )

--Basic Theme Button---------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
end

function PANEL:SetText(text , font)
	self.Text = text
	self.font = font
end

function PANEL:SetFunc(func )
	self.Func = func
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.Func then self.Func() end
	end
end

function PANEL:Paint()
	if self:IsHovered() then
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonouthi )
		draw.RoundedBox( 8, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.buttonhi )
	else
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
		draw.RoundedBox( 8, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	end

	if self.Text then
		if self:IsHovered() then
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcolhi, 1, 1, 1, Theme.fontcolout)	
		else
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
		end
	end
	return true
end
vgui.Register( "ThemeButton", PANEL, "Panel" )

--Basic Theme CheckBox---------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.toggle = false
end

function PANEL:SetText(text, font )
	if self.Text then self.Text:Remove() end
	--self.Text = vgui.Create( "ThemeText" , self:GetParent())
	self.Text = vgui.Create( "ThemeTextLink" , self)
	self.Text:SetSize( 0, 0)
	self.Text:SetPos( self:GetTall() * 1.1, self:GetTall() * 0.5)
	--self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
	self.Text:SetText(text,font,0,0.5)
	--self.Text:SetMouseInputEnabled( false )
end

function PANEL:SetFunc(func )
	self.Func = func
end

function PANEL:Toggle( )
	self.toggle = !self.toggle
	return self.toggle
end

function PANEL:SetToggle(state )
	self.toggle = state
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		self.Func()
	end
end

function PANEL:Paint()

	if self:IsHovered() then
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonouthi )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.buttonhi )
	else
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	end

	if self.toggle then
		surface.SetMaterial( tex_tick )
	else
		surface.SetMaterial( tex_cross )
	end
	surface.SetDrawColor( 255, 255, 255, 255 )
	local tall = self:GetTall() 
	surface.DrawTexturedRect( tall*0.1, tall*0.1, tall*0.85, tall*0.85)
	
	return true
end
vgui.Register( "ThemeCheckBox", PANEL, "Panel" )

--Basic Theme MultiBox---------------------------------------------------------------------------------------
local PANEL = {}
function PANEL:Init()
	self:SetVisible( false )
	self:SetMouseInputEnabled( true )
	btn = nil
	hovering = -1
end

function PANEL:SetText(text,font, btn)
	self.Text = text
	self.font = font
	self.btn = btn

	surface.SetFont( font )
	
	self.height = 0 
	
	for _, tx in ipairs(self.Text) do
		local width, height = surface.GetTextSize( tx )
		--if width > self.width then self.width = width end
		self.height = self.height + math.floor(height * 1.1)
	end
	self.spacing = self.height / #self.Text

	self:SetSize( self:GetWide(), self.height)
end

function PANEL:Paint()
	--if self:IsHovered() then
	draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), self.btn.colour3 )
	--draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	
	local alternate = false
	local col = self.btn.colour
	local space = math.ceil(self.spacing)
	if self.Text then
		for i, tx in ipairs(self.Text) do
			if i == 1 then draw.RoundedBoxEx( 6, 1, space*(i-1)+1, self:GetWide()-2, space-2, col ,true,true,false,false) 
			elseif i == #self.Text then draw.RoundedBoxEx( 6, 1, space*(i-1)-1, self:GetWide()-2, space, col ,false,false,true,true)
			else draw.RoundedBoxEx( 6, 1, space*(i-1)-1, self:GetWide()-2, space, col ,false,false,false,false) end
			if i == self.hovering then
				draw.SimpleTextOutlined(tx , self.font, self:GetWide() * 0.5 , i * self.spacing - self.spacing * 0.5, Theme.fontcolho, 1, 1, 1, Theme.fontcolout)
			else
				draw.SimpleTextOutlined(tx , self.font, self:GetWide() * 0.5 , i * self.spacing - self.spacing * 0.5, Theme.fontcol, 1, 1, 1, Theme.fontcolout)
			end
			
			alternate = !alternate
			if alternate then
				col = self.btn.colour2
			else
				col = self.btn.colour
			end
		end
	end
	
	return true
end

function PANEL:SetColour(col, col2)
	self.colour = col or self.colour
	self.colour2 = col2 or self.colour2
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.hovering  > 0 and self.hovering <= #self.Text then
			self.btn:SetValue(self.hovering)
			self.btn.Func()
		end
	end
end

function PANEL:Think()
	if !IsValid(self.btn) then return end
	if !self:IsHovered() and !self.btn:IsHovered() then
		if self:IsVisible() then self:SetVisible( false ) end
	else
		local locx, locy = self:ScreenToLocal( 0, gui.MouseY() )
		--print(locy / self.spacing )
		self.hovering = math.Round(locy / self.spacing + 0.5)
	end
end

vgui.Register( "ThemeMultiBox2", PANEL, "Panel" )

local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.list = nil
	self.value = 0
	self.extended = nil
	self.colour = Theme.box
	self.colour2 = Theme.box2
	self.colour3 = Theme.buttonout 
end

function PANEL:SetText(words,font, valuelist, value)
	
	if self.Text then self.Text:Remove() end
	self.words = words
	--self.Text = vgui.Create( "ThemeText" , self:GetParent())
	self.Text = vgui.Create( "ThemeTextLink" , self)
	self.list = valuelist
	self.Text:SetSize( 0, 0)
	self.Text:SetPos( self:GetTall() * 1.1, self:GetTall() * 0.5)
	--self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
	self.Text:SetText(words..valuelist[value],font,0,0.5)
	--self.Text:SetMouseInputEnabled( false )
	
	self.extended = vgui.Create( "ThemeMultiBox2" , self:GetParent())
	self.extended:SetSize(self:GetWide() , self:GetTall())
	self.extended:SetPos(self:GetX(), self:GetY() +self:GetTall())
	self.extended:SetText(valuelist, font, self)

	--self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
end

function PANEL:SetFunc(func )
	self.Func = func
end

function PANEL:SetValue(value )
	self.value = math.Clamp(value,1,#self.list)
	self.Text:SetText(self.words..self.list[self.value],nil,0,0.5)
end

function PANEL:GetValue( )
	return self.value
end

function PANEL:SetColour(col, col2, col3)
	self.colour = col or self.colour
	self.colour2 = col2 or self.colour2 
	self.colour3 = col3 or self.colour3 
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.extended then 
			self.extended:SetVisible( true ) 
			self.extended:MoveToFront()
		end
	end
end

function PANEL:Paint()

	if self:IsHovered() then
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonouthi )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.buttonhi )
	else
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	end


	surface.SetMaterial( tex_cog )
	surface.SetDrawColor( 255, 255, 255, 255 )
	local tall = self:GetTall() 
	surface.DrawTexturedRect( tall*0.1, tall*0.1, tall*0.85, tall*0.85)
	
	return true
end
vgui.Register( "ThemeMultiBox", PANEL, "Panel" )

--Basic Theme Text---------------------------------------------------------------------------------------
--Normal Text Display -----------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
	self.colour = Theme.fontcol
	self.outcol = Theme.fontcolout
end

function PANEL:SetText(text,font, alignX,alignY )
	self.Text = text
	self.font = font or self.font
	surface.SetFont( self.font )

	self:SetX( self:GetX() + self.width)
	self:SetY( self:GetY() + self.height)

	local width, height = surface.GetTextSize( text )
	self.width =  math.floor(width * alignX)
	self.height =  math.floor(height * alignY)
	self:SetSize( width + 2, height + 2)
	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:SetColour(col, out)
	self.colour = col or self.colour
	self.outcol = out or self.outcol
end

function PANEL:Paint()

	if self.Text then
	
		draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , self.colour, 1, 1, 1, self.outcol)	
	end
	return true
end
vgui.Register( "ThemeText", PANEL, "Panel" )

--Basic Theme Text Linked------------------------------------------------------------------------------------
--Text that hilights when parent hovered --------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
end

function PANEL:SetText(text,font, alignX,alignY )
	self.Text = text
	self.font = font or self.font
	surface.SetFont( self.font )

	self:SetX( self:GetX() + self.width)
	self:SetY( self:GetY() + self.height)

	local width, height = surface.GetTextSize( text )
	self.width =  math.floor(width * alignX)
	self.height =  math.floor(height * alignY)
	self:SetSize( width + 2, height + 2)
	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:Paint()

	if self.Text then
		--draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
		
		if self:GetParent():IsHovered() then
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcolhi, 1, 1, 1, Theme.fontcolout)	
		else
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
		end
	end
	return true
end
vgui.Register( "ThemeTextLink", PANEL, "Panel" )

--Normal Text Display With Box---------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
	self.colour = Theme.fontcol
	self.outcol = Theme.fontcolout
end

function PANEL:SetText(text,font, alignX,alignY )
	self.Text = text
	self.font = font or self.font
	surface.SetFont( self.font )

	self:SetX( self:GetX() + self.width)
	self:SetY( self:GetY() + self.height)

	local width, height = surface.GetTextSize( text )
	self.width =  math.floor(width * alignX)
	self.height =  math.floor(height * alignY)
	self:SetSize( width + 12, height + 8)
	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:SetColour(col, out)
	self.colour = col or self.colour
	self.outcol = out or self.outcol
end

function PANEL:Paint()
	draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.backcol4)
	draw.RoundedBox( 8, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.backcol4)
	if self.Text then
		draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , self.colour, 1, 1, 1, self.outcol)	
	end
	return true
end
vgui.Register( "ThemeTextBox", PANEL, "Panel" )

--Basic Theme TextMultiLine ---------------------------------------------------------------------------------------
--Currently only has middle aligned text currently ----------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
	self.Text = nil
end

function PANEL:SetText(text,font, alignX, alignY, spacing)
	
	if istable(text) then
		self.Text = text
	else
		self.Text = {text}
	end
	

	self.font = self.font or font
	self.spacing = spacing
	surface.SetFont( self.font )
	
	self:SetX( self:GetX() + self.width)
	self:SetY( self:GetY() + self.height)
	
	self.alignX = alignX or self.alignX
	self.alignX = 0
	
	self.width = 0
	self.height = 0 
	for _, tx in ipairs(self.Text) do
		local width, height = surface.GetTextSize( tx )
		if width > self.width then self.width = width end
		self.height = self.height + height + spacing
	end

	self.spacing = self.height / #self.Text

	self:SetSize( self.width + 2, self.height + 2)
	
	self.width = math.floor(self.width * alignX)
	self.height =  math.floor(self.height * alignY)

	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:Paint()
	if self.Text then
		for i, tx in ipairs(self.Text) do
			
			draw.SimpleTextOutlined(tx , self.font, self:GetWide() * self.alignX - (self.alignX - 0.5), i * self.spacing - self.spacing * 0.5, Theme.fontcol, self.alignX*2, 1, 1, Theme.fontcolout)
		end
	end
	return true
end
vgui.Register( "ThemeTextMulti", PANEL, "Panel" )


------------------------------------------------------------------------------------------------------------------------
---------------------Vertical Scrollbox---------------------------------------------------------------------------------

local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self:SetMouseInputEnabled( true )
	self.InternalY = 0
	self.ExtraY = 0
	self.MaxY = 0
	self.BarY = 0
	self.BarSize = 1
	self.PaintExtra = nil
end

function PANEL:UpdateMaxY(maxy)
	self.MaxY = maxy
	if self.MaxY > self:GetTall() then
		self.BarSize = self:GetTall() * (self:GetTall()/self.MaxY)
		self.ExtraY = maxy - self:GetTall()
	end
end

function PANEL:OnMouseWheeled( scrollDelta )
	self:ScrollAmount(-scrollDelta * (self:GetTall()* 0.1))
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		local locx, locy = self:ScreenToLocal( gui.MouseX() , gui.MouseY() )
		--print(locy / self.spacing )
		if locx > self:GetWide() - ScrH() * 0.03 and locx < self:GetWide() then
			--local halfbar = self.BarSize * 0.5
			if locy > 0 and locy < self:GetTall() then
				local ypress = locy - self.BarSize * 0.5
				if ypress < 0 then ypress = 0 
				elseif ypress > self:GetTall() - self.BarSize then ypress = self:GetTall() - self.BarSize end
				local newY = 1 / (self:GetTall() - self.BarSize) * ypress
				newY = newY * self.ExtraY
				self:ScrollAmount( newY - self.InternalY )
				self.held = true
				self:MouseCapture( true )
			end
		end
	end
end

function PANEL:OnMouseReleased( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.held then self.held = false self:MouseCapture( false ) end
	end
end

function PANEL:Think( keyCode )
	if self.held then
		local locx, locy = self:ScreenToLocal( gui.MouseX() , gui.MouseY() )
		local ypress = locy - self.BarSize * 0.5
		if ypress < 0 then ypress = 0 
		elseif ypress > self:GetTall() - self.BarSize then ypress = self:GetTall() - self.BarSize end
		local newY = 1 / (self:GetTall() - self.BarSize) * ypress
		newY = newY * self.ExtraY
		self:ScrollAmount( newY - self.InternalY )
	end
end

function PANEL:ScrollAmount( amount )
	local newY = self.InternalY + math.floor(amount)
	if newY < 0 then newY = 0 end
	if newY > self.ExtraY then newY = self.ExtraY end
	
	self.BarY = (self:GetTall()-self.BarSize) / self.ExtraY * newY
	
	local moved = self.InternalY - newY
	for i, cd in ipairs(self:GetChildren()) do
		cd:SetY(cd:GetY() + moved)
	end
	
	self.InternalY = newY
end

function PANEL:Paint()
	draw.RoundedBox( 1, 0, 0, self:GetWide(), self:GetTall(), Theme.backcol2 )
	if self.MaxY > self:GetTall() then
		draw.RoundedBox( 6, self:GetWide() - ScrH() * 0.03, 0, ScrH() * 0.03, self:GetTall(), Theme.barback )
		draw.RoundedBox( 6, self:GetWide() - ScrH() * 0.03, self.BarY, ScrH() * 0.03, self.BarSize, Theme.button )
	end
	
	if self.PaintExtra then self.PaintExtra() end
	
	return true
end
vgui.Register( "ThemeVertScoll", PANEL, "Panel" )

---------------------------------------------------------------------------------------
-----------------------------------Creator Functions-----------------------------------
---------------------------------------------------------------------------------------
function New_ThemeText(parent,xpos,ypos,text,font,xalign,yalign)
	local element = vgui.Create( "ThemeText" , parent)
	element:SetPos( xpos, ypos)
	element:SetText(text,font,xalign,yalign)

	return element
end

function New_ThemeTextBox(parent,xpos,ypos,text,font,xalign,yalign)
	local element = vgui.Create( "ThemeTextBox" , parent)
	element:SetPos( xpos, ypos)
	element:SetText(text,font,xalign,yalign)

	return element
end

function New_ThemeTextMulti(parent,xpos,ypos,text,font,xalign,yalign,spacing)
	local element = vgui.Create( "ThemeTextMulti" , parent)
	element:SetPos( xpos, ypos)
	element:SetText(text,font,xalign,yalign,spacing)

	return element
end

function New_ThemeButton(parent,xpos,ypos,wide,tall,text,font)
	local element = vgui.Create( "ThemeButton" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	element:SetText(text,font)

	return element
end

function New_ThemeCheck(parent,xpos,ypos,wide,tall,text,font)
	local element = vgui.Create( "ThemeCheckBox" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	element:SetText(text,font)
	
	return element
end

function New_ThemeVertScroll(parent,xpos,ypos,wide,tall)
	local element = vgui.Create( "ThemeVertScoll" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	
	return element
end

function New_ThemeGameIcon(parent,xpos,ypos,wide,tall,game,value)
	local element = vgui.Create( "ThemeGameIcon" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	element:SetGame(game,value)
	
	return element
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

function DrawThickLine(xx,yy,x2,y2, width)
	local pos1 = Vector( xx, yy, 0 ) 
	local pos2 = Vector( x2, y2, 0 ) 
	local angle = Vector(pos1)
	angle:Sub(pos2)
	angle:Normalize()
	angle:Rotate( Angle(0,90,0) )
	angle:Mul( width)
	local quad = {
		{ x = xx - angle[1], y = yy - angle[2]},
		{ x = xx + angle[1], y = yy + angle[2]},
		{ x = x2 + angle[1], y = y2 + angle[2]},
		{ x = x2 - angle[1], y = y2 - angle[2]}
	}
	surface.DrawPoly( quad )

end

function DrawPercentBar(xx,yy,ww,hh, value,total,col,col2,colout)
	colout = colout or Theme.fontblack

	local percent = 0 
	if total !=0 then percent = math.floor(ww / total * value) end

	if percent > 0 then
		surface.SetDrawColor(col:Unpack())
		surface.DrawRect( xx, yy, percent, hh )
		surface.SetDrawColor(col2:Unpack())
		surface.DrawRect( xx+percent, yy, ww-percent, hh )
	else
		surface.SetDrawColor(col2:Unpack())
		surface.DrawRect( xx, yy, ww, hh )
	end
	
	
	surface.SetDrawColor(colout:Unpack())
	surface.DrawOutlinedRect( xx-1, yy-1, ww+2, hh+2, 1 )
end