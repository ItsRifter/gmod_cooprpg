

local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.75 * HL2C_Client:Get_UIScale()
	local varW = varH * 1.5
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.25)
	self:SetSize( varW, varH )
	
	--self:MakePopup()
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	self.tabs = {}
	--self:AddTab(Create_QMenu_Inventory(self))
	--self:AddTab(Create_QMenu_Skills(self))
	--self:AddTab(Create_QMenu_Shop(self))
	--self:AddTab(Create_QMenu_Achievements(self))
	
	local Btn = New_ThemeButton(self, tall * 0.01, tall * 0.01,wide* 0.13,tall* 0.06,translate.Get("Basic_Inventory"),"Font_Small")
	Btn:SetFunc(
		function()
			--self:SetTab(1)
		end
	)
	
	local Btn = New_ThemeButton(self, tall * 0.01 + wide* 0.14, tall * 0.01,wide* 0.13,tall* 0.06,translate.Get("Basic_Skills"),"Font_Small")
	Btn:SetFunc(
		function()
			--self:SetTab(2)
		end
	)
	
	local Btn = New_ThemeButton(self, tall * 0.01+ wide* 0.28, tall * 0.01,wide* 0.13,tall* 0.06,translate.Get("Basic_Shop"),"Font_Small")
	Btn:SetFunc(
		function()
			--self:SetTab(3)
		end
	)
	
	local Btn = New_ThemeButton(self, wide* 0.82 - tall * 0.01, tall * 0.01,wide* 0.18,tall* 0.06,translate.Get("Basic_Achievements"),"Font_Small")
	Btn:SetFunc(
		function()
			--self:SetTab(4)
		end
	)
	
	self:SetVisible( true )
end




---------------------------------------------------------------------------

function PANEL:AddTab(element)
	table.insert(self.tabs,element)
end

function PANEL:SetTab(value)
	for i, e in ipairs(self.tabs) do
		if !IsValid(e) then continue end
		if i == value then 
			e:SetVisible(true)
		else
			e:SetVisible(false)
		end
	end
end

---------------------------------------------------------------------------

function PANEL:Paint()

	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall() * 0.08-1, Theme.backcol,true, true,true,true)

	return true
end
vgui.Register( "QMenu_Main", PANEL, "Panel" )

---------------------------------------------------------------------------
---------------------------------------------------------------------------

local lasttime = lasttime or nil

if IsValid(HL2C_Client.QMenu) then HL2C_Client.QMenu:Remove() end

function HL2C_Client:ControlQMenu(toggle)
	if toggle then
		if not IsValid(HL2C_Client.QMenu) then
			HL2C_Client:RemoveHelpMenu()
			HL2C_Client.QMenu = vgui.Create("QMenu_Main")
			lasttime = CurTime()
			gui.EnableScreenClicker( true )
		else
			HL2C_Client:RemoveQMenu()
		end
	else
		if lasttime and CurTime() < lasttime + 0.25 then return end
		HL2C_Client:RemoveQMenu()
	end


end

function HL2C_Client:RemoveQMenu()
	if IsValid(HL2C_Client.QMenu) then
		HL2C_Client.QMenu:Remove()
		gui.EnableScreenClicker( false )
	end
end

function GM:OnSpawnMenuOpen()
	HL2C_Client:ControlQMenu(true)
	print("open")
end

function GM:OnSpawnMenuClose()
	HL2C_Client:ControlQMenu(false)
	print("close")
end