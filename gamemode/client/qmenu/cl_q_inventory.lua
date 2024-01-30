------------------------------------------------------------------------------------------------
--------Inventory Tab---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self.PlayerModel = vgui.Create("DModelPanel", self)


	self:SetVisible( true )
end

function PANEL:CorrectEyes()
	local eyepos = self.PlayerModel.Entity:GetBonePosition(self.PlayerModel.Entity:LookupBone("ValveBiped.Bip01_Head1")) or nil

	if eyepos ~= nil then
		eyepos:Add(Vector(0, 0, -2))
		--self.PlayerModel.Entity:SetPos(self.PlayerModel.Entity:GetPos() + Vector(0, 0, 2.5))
		self.PlayerModel:SetCamPos(eyepos - Vector(-50, 0, 10))
		self.PlayerModel:SetLookAt(eyepos- Vector(0, 0, 17))
	end
end

function PANEL:Setup()

	local wide = self:GetWide()
	local tall = self:GetTall()
	self.modelchanged = false

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
	
	self.PlayerModel:SetSize(wide * 0.23, tall * 0.82 )
	self.PlayerModel:SetPos(wide * 0.01, tall * 0.12 )
	self.PlayerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
	self.PlayerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
	self.PlayerModel:SetAmbientLight(Vector(-64, -64, -64))
	self.PlayerModel:SetModel( LocalPlayer():GetModel() )
	self.PlayerModel:SetFOV( 30)
	--self.PlayerModel.Angles = Angle(0, 25, 0)
	
	self.PlayerModel.Angles = Angle(0, 25, 0)

	function self.PlayerModel:DragMousePress()
		self.PressX, self.PressY = input.GetCursorPos()
		self.Pressed = true
	end

	function self.PlayerModel:DragMouseRelease() self.Pressed = false end	
	self:CorrectEyes()
	
	function self.PlayerModel:LayoutEntity( ent )
		if self.Pressed then
			local mx, my = input.GetCursorPos()
			self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

			self.PressX, self.PressY = input.GetCursorPos()
			ent:SetAngles(self.Angles)
		end	
	end
	
	local lvlacc = HL2C_Global:GetLvlAccess()
	
	self.ModelGroup = vgui.Create( "ThemeMultiBox" , self)
	self.ModelGroup:SetSize( wide * 0.23, math.ceil(tall * 0.05))
	self.ModelGroup:SetPos( wide * 0.01, tall * 0.01)
	self.ModelGroup:SetText("","Font_Small",HL2C_Global:GetModelList(lvlacc),1)
	self.ModelGroup:SetColour(Theme.box3,Theme.box4,Theme.backcol3)
	self.ModelGroup:SetFunc(
		function(value)
			--Client_Config.CrossType = MultiBox.value
			local group = HL2C_Global:GetModelGroups(self.ModelGroup.Text.Text,lvlacc)
			self.ModelGroup.extended:SetVisible( false ) 
			if group then 
				self.modelchanged = true
				self.PlayerModel:SetModel(HL2C_Global:GetModelFromGroup(self.ModelGroup.Text.Text))
				self.ModelSelect:SetText("","Font_Small",HL2C_Global:GetModelGroups(self.ModelGroup.Text.Text,lvlacc),1) 
				self:CorrectEyes()
			end
		end
	)
	
	self.ModelSelect = vgui.Create( "ThemeMultiBox" , self)
	self.ModelSelect:SetSize( wide * 0.23, math.ceil(tall * 0.05))
	self.ModelSelect:SetPos( wide * 0.01, tall * 0.07)
	self.ModelSelect:SetText("","Font_Small",HL2C_Global:GetModelGroups("Citizens",lvlacc),1)
	self.ModelSelect:SetColour(Theme.box3,Theme.box4,Theme.backcol3)
	self.ModelSelect:SetFunc(
		function(value)
			local mdl = HL2C_Global:GetModelFromName(self.ModelGroup.Text.Text,self.ModelSelect.Text.Text,lvlacc)
			if mdl then self.modelchanged = true self.PlayerModel:SetModel(mdl) end
			self:CorrectEyes()
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.01, tall * 0.94,wide* 0.23,tall* 0.05,translate.Get("INV_ChangeModel"),"Font_Small")
	Btn:SetFunc(
		function()
			if !self.modelchanged then return end
			surface.PlaySound( "buttons/button14.wav" )
			--net.Start("HL2CR_Model_Update")
			--	net.WriteString(self.ModelGroup.Text.Text)
			--	net.WriteString(self.ModelSelect.Text.Text)
			--net.SendToServer()
			HL2C_Client:AddChatMessage({HL2R_TEXT_RED, "Not implemented yet :3"})
			self.modelchanged = false
		end
	)


	
end


function PANEL:Paint()
	
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	draw.RoundedBox( 8, 0, 0, math.floor(wide * 0.25), tall, Theme.backcol2)
	
	--draw.RoundedBox( 4, wide * 0.25,tall * 0.01,wide * 0.49,tall * 0.05, Theme.backcol)
	--draw.RoundedBox( 4, wide * 0.75,tall * 0.01,wide * 0.24,tall * 0.05, Theme.backcol)
	
	--draw.RoundedBox( 4, wide * 0.75,tall * 0.07,wide * 0.24,tall * 0.86, Theme.backcol2)
	
	return true
end

vgui.Register( "QMenu_Inventory", PANEL, "Panel" )

function HL2C_Client:CreateInventory(parent)
	local element = vgui.Create("QMenu_Inventory",parent)
	
	local tall = parent:GetTall()
	local height = math.floor(tall * 0.9)
	
	element:SetPos( 0, tall-height)
	element:SetSize( parent:GetWide(), height )
	element:Setup()
	return element
end