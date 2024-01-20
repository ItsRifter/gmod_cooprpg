--------------------------------------------------------------------------------------------------------------
--Help Panel----------- --------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.7 * HL2C_Client:Get_UIScale()
	local varW = varH * 1.4 
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.5)
	self:SetSize( varW, varH )
	
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	local Text = New_ThemeText(self,wide * 0.425, tall * 0.01,translate.Get("HM_Title"),"Font_Normal",0.5,0)

	local Text = New_ThemeText(self,wide * 0.425, tall* 0.08,translate.Get("HM_Map")..game.GetMap(),"Font_Small",0.5,0)
	
	local Text = New_ThemeTextMulti(self,wide * 0.425, tall * 0.15,translate.Get("HM_Info"),"Font_Normal",0.5,0,2)
	
	self.OpPanel = vgui.Create( "Panel" , self)
	self.OpPanel:SetSize(self:GetWide() * 0.8, self:GetTall() * 0.7)
	self.OpPanel:SetPos(self:GetWide() * 0.02 , self:GetTall() * 0.20)
	self.OpPanel:SetVisible(false)
	
	function self:ShowOptions(show_bool)
		self.OpPanel:SetVisible(show_bool)
		Text:SetVisible( not show_bool )
	end
	
--------------------------------------------------------------------------------------------------------------
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.01,wide* 0.15,tall* 0.05,translate.Get("Basic_Close"),"Font_Normal")
	Btn:SetFunc(
		function()
			gui.EnableScreenClicker( false ) 
			HL2C_Client.HelpMenu:Remove()
		end
	)
--------------------------------------------------------------------------------------------------------------
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.16,wide* 0.15,tall* 0.05,translate.Get("Basic_Help"),"Font_Small")
	Btn:SetFunc(
		function()
			self:ShowOptions(false)
			Text:SetText(translate.Get("HM_Info"),nil,0.5,0, 2)
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.22,wide* 0.15,tall* 0.05,translate.Get("Basic_Cmd"),"Font_Small")
	Btn:SetFunc(
		function()
			self:ShowOptions(false)
			Text:SetText(translate.Get("HM_Commands"),nil,0.5,0, 2)
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.28,wide* 0.15,tall* 0.05,translate.Get("Basic_Pets"),"Font_Small")
	Btn:SetFunc(
		function()
			self:ShowOptions(false)
			Text:SetText(translate.Get("HM_Pets"),nil,0.5,0, 2)
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.93,wide* 0.15,tall* 0.05,translate.Get("Basic_Options"),"Font_Small")
	Btn:SetFunc(
		function()
			self:ShowOptions(true)
		end
	)
--------------------------------------------------------------------------------------------------------------
	local OpPanel = self.OpPanel
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.1,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_HideXp"),"Font_Small")
	Check:SetToggle(HL2C_Client.Config.HideXP)
	Check:SetFunc(
		function()
			HL2C_Client.Config.HideXP = Check:Toggle()
			HL2C_Client.Config_Changed = true
		end
	)
	
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.5,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_Cross"),"Font_Small")
	Check:SetToggle(HL2C_Client.Config.NewCross)
	Check:SetFunc(
		function()
			HL2C_Client.Config.NewCross = Check:Toggle()
			HL2C_Client.Config_Changed = true
		end
	)
	
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.63, OpPanel:GetTall() * 0.5,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_CrossDy"),"Font_Small")
	Check:SetToggle(HL2C_Client.Config.DynamicCross)
	Check:SetFunc(
		function()
			HL2C_Client.Config.DynamicCross = Check:Toggle()
			HL2C_Client.Config_Changed = true
		end
	)
	
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.7,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_HideDmg"),"Font_Small")
	Check:SetToggle(HL2C_Client.Config.HideDmg)
	Check:SetFunc(
		function()
			HL2C_Client.Config.HideDmg = Check:Toggle()
			HL2C_Client.Config_Changed = true
		end
	)
	
	local MultiBox = vgui.Create( "ThemeMultiBox" , OpPanel)
	MultiBox:SetSize( OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08)
	MultiBox:SetPos( OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.6)
	MultiBox:SetText("Type : ","Font_Small",{[1] = "Plus",[2] = "Circle",[3] = "Bar",[4]="None"},1)
	MultiBox:SetValue(HL2C_Client.Config.CrossType)
	MultiBox:SetFunc(
		function(value)
			HL2C_Client.Config.CrossType = MultiBox.value
			HL2C_Client.Config_Changed = true
		end
	)
	
	local MultiBox = vgui.Create( "ThemeMultiBox" , OpPanel)
	MultiBox:SetSize( OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08)
	MultiBox:SetPos( OpPanel:GetWide() * 0.63, OpPanel:GetTall() * 0.6)
	MultiBox:SetText("UI: ","Font_Small",{[1] = "Normal",[2] = "Smaller",[3] = "Smallest"},1)
	MultiBox:SetValue(HL2C_Client.Config.UI_Scale)
	MultiBox:SetFunc(
		function(value)
			HL2C_Client.Config.UI_Scale = MultiBox.value
			HL2C_Client.Config_Changed = true
			HL2C_Client:CreateFonts()
			HL2C_Client:OpenHelpMenu(true)
		end
	)
	
	self:SetVisible( true )
end

function PANEL:Paint()
	local barsize = math.floor(self:GetTall() * 0.07)
	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), barsize, Theme.backcol,true, true,false,false)
	draw.RoundedBoxEx( 1, 0, barsize, self:GetWide(), barsize, Theme.backcol2,false, false,false,false)
	draw.RoundedBoxEx( 8, 0, barsize * 2, self:GetWide(), self:GetTall() - barsize * 2, Theme.backcol,false,false,true,true)

	return true
end

vgui.Register( "HelpMenu", PANEL, "Panel" )

function HL2C_Client:OpenHelpMenu(options)
	if ( HL2C_Client.HelpMenu ) then HL2C_Client.HelpMenu:Remove()end
	HL2C_Client.HelpMenu = vgui.Create( "HelpMenu" )
	if options then HL2C_Client.HelpMenu:ShowOptions(true) end
	gui.EnableScreenClicker( true )
end