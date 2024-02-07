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

------------------------------------------------------------------------------
------------------------------------------------------------------------------

	local NameText = New_ThemeText(self,wide * 0.28, tall  * 0.03,LocalPlayer():Nick(),"Font_Normal",0,0.5)
	local IDText = New_ThemeText(self,wide * 0.98 - tall * 0.23, tall  * 0.03,LocalPlayer():SteamID(),"Font_Normal",1,0.5)
	
	local avatar = vgui.Create( "AvatarImage", self )
	avatar:SetSize(tall * 0.23, tall * 0.23)
	avatar:SetPos(wide * 0.99 - tall * 0.23 + tall * 0.01, tall * 0.01)
	avatar:SetPlayer(LocalPlayer(), 128)
	
	local text = translate.Get("CHAR_Lvl")
	local LvlText = New_ThemeText(self,wide * 0.28, tall  * 0.1,text,"Font_Normal",0,0.5)
	
	local text = translate.Get("CHAR_Exp")
	local ExpText = New_ThemeText(self,wide * 0.28, tall  * 0.18,text,"Font_Normal",0,0.5)



------------------------------------------------------------------------------
------------------------------------------------------------------------------

	
end


function PANEL:Paint()
	
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	draw.RoundedBox( 8, 0, 0, math.floor(wide * 0.25), tall, Theme.backcol2)
	
	draw.RoundedBoxEx( 8, wide - math.floor(wide * 0.73), 0, math.floor(wide * 0.73), math.floor(tall * 0.06), Theme.backcol,true,true,false,false)
	draw.RoundedBoxEx( 8, wide - math.floor(wide * 0.73), math.floor(tall * 0.06), math.floor(wide * 0.58), math.floor(tall * 0.19), Theme.backcol2,false,false,true,false)
	draw.RoundedBoxEx( 8, wide - math.floor(wide * 0.73)+math.floor(wide * 0.58), math.floor(tall * 0.06), math.floor(wide * 0.73)-math.floor(wide * 0.58), math.floor(tall * 0.19), Theme.backcol,false,false,false,true)
	
	--self.ply:GetNWInt("hl2c_stat_exp", -1) .. "/" .. self.ply:GetNWInt("hl2c_stat_expreq", 0)
	local experience = LocalPlayer():GetNWInt("hl2c_stat_exp", -1) 
	local total = LocalPlayer():GetNWInt("hl2c_stat_expreq", -1) 
	
	DrawPercentBar(math.floor(wide * 0.4),math.floor(tall * 0.15),math.floor(wide * 0.43),math.floor(tall * 0.08), experience,total,Theme.backcol,Theme.backcol4)
	
	--draw.RoundedBox( 8, wide - math.floor(wide * 0.73), tall - math.floor(tall * 0.72), math.floor(wide * 0.73), math.floor(tall * 0.72), Theme.backcol2)
	
	return true
end

vgui.Register( "QMenu_Character", PANEL, "Panel" )

function HL2C_Client:CreateCharacter(parent)
	local element = vgui.Create("QMenu_Character",parent)
	
	local tall = parent:GetTall()
	local height = math.floor(tall * 0.9)
	
	element:SetPos( 0, tall-height)
	element:SetSize( parent:GetWide(), height )
	element:Setup()
	return element
end