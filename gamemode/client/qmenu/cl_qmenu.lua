

local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.75 * HL2C_Client:Get_UIScale()
	local varW = varH * 1.5
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.25)
	self:SetSize( math.floor(varW), math.floor(varH) )
	
	--self:MakePopup()
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	self.tabs = {}
	self:AddTab(HL2C_Client:CreateCharacter(self))
	self:AddTab(HL2C_Client:CreateSkills(self))
	--self:AddTab(Create_QMenu_Skills(self))
	--self:AddTab(Create_QMenu_Shop(self))
	self:AddTab(HL2C_Client:CreateAchievement(self))
	
	local tabw = math.floor(wide*0.12)
	local tabh = math.floor(tall*0.06)
	
	local taboff = math.floor(wide*0.008)
	
	local Btn = New_ThemeButton(self, taboff, tall * 0.01,tabw,tabh,translate.Get("Basic_Character"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(1)
		end
	)
	
	local Btn = New_ThemeButton(self, taboff * 2 + tabw , tall * 0.01,tabw,tabh,translate.Get("Basic_Inventory"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(2)
		end
	)
	
	local Btn = New_ThemeButton(self, taboff * 3 + tabw * 2, tall * 0.01,tabw,tabh,translate.Get("Basic_Skills"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(3)
		end
	)
	
	local Btn = New_ThemeButton(self, taboff * 4 + tabw * 3, tall * 0.01,tabw,tabh,translate.Get("Basic_Shop"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(4)
		end
	)
	
	local Btn = New_ThemeButton(self, wide- taboff - tabw* 1.5, tall * 0.01,tabw * 1.5,tabh,translate.Get("Basic_Achievements"),"Font_Small")
	Btn:SetFunc(
		function()
			self:SetTab(5)
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
	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), math.floor(self:GetTall() * 0.08), Theme.backcol,true, true,true,true)

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
end

function GM:OnSpawnMenuClose()
	HL2C_Client:ControlQMenu(false)
end