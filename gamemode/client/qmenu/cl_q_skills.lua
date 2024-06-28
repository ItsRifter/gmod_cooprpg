-------------------------------------------------------------------------------------------------------
--Skill Panel------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self.status = 0
	self.skillname = nil
end

function PANEL:Setup(skillname)
	local scale = self:GetParent():GetWide()
	local scalehalf = scale * 0.075
	self.skillname = skillname
	self.skilldata = HL2C_Skills:GetSkill(skillname)
	
	self:SetMouseInputEnabled (true)
	
	self:SetPos( self.skilldata.pos.x * scale - scalehalf, self.skilldata.pos.y * scale - scalehalf)
	self:SetSize( scale*0.15, scale*0.15 )
	local wide = self:GetWide()
	--local tall = self:GetTall()
	
	self.Name = New_ThemeText(self,wide * 0.5, wide * 0.1,self.skilldata.name,"Font2_Tiny",0.5,0.5)
	
	self.SkillIcon = vgui.Create("DImage", self)
	self.SkillIcon:SetSize(wide * 0.6, wide * 0.6)
	self.SkillIcon:SetPos(wide * 0.2, wide * 0.2)
	
	if self.skilldata.icon then self.SkillIcon:SetImage(self.skilldata.icon) end
	
	self.Cost = New_ThemeText(self,wide * 0.5, wide * 0.9,"NIL","Font2_Tiny",0.5,0.5)
	
	self.Desc = New_ThemeTextBox(self:GetParent(),self:GetX()+wide * 0.5, self:GetY()+wide * 1.10,self.skilldata.name.."_DESC","Font2_Tiny",0.5,0.5)
	self:Update()
end

function PANEL:Update()
	if HL2C_Skills:HasSkill() then
		self.Cost:SetText("Unlocked",nil,0.5,0.5)
		self.Cost:SetColour(Theme.fontgreen)
		self.Name:SetText(self.skilldata.name,nil,0.5,0.5)
		if self.skilldata.icon then self.SkillIcon:SetImage(self.skilldata.icon) end
		self.status = 2
	elseif HL2C_Skills:SkillUnlocked() then
		self.Cost:SetText(translate.Get("QMenu_SkillPnl_SkillCost")..self.skilldata.cost,nil,0.5,0.5)
		if HL2CR_SkillsPoints() < self.skilldata.cost then
			self.Cost:SetColour(Theme.fontred)
		else self.Cost:SetColour(Theme.fontcol) end
		self.Name:SetText(self.skilldata.name,nil,0.5,0.5)
		if self.skilldata.icon then self.SkillIcon:SetImage(self.skilldata.icon) end
		self.status = 1
	else
		self.Cost:SetText("Locked",nil,0.5,0.5)
		self.Cost:SetColour(Theme.fontred)
		self.Name:SetText("???",nil,0.5,0.5)
		self.SkillIcon:SetImage("materials/hl2c/icons/locked.png")
		self.status = 0
	end
end

function PANEL:GetCenter()
	local var,var2 = self:GetPos()
	var = var + self:GetWide()*0.5
	var2 = var2 + self:GetTall()*0.5
	return var,var2
end

function PANEL:Think()
	if self:IsHovered() then
		if !self.Desc:IsVisible() and self.status > 0 then self.Desc:SetVisible(true) self.Desc:MoveToFront() end
	else
		if self.Desc:IsVisible() then self.Desc:SetVisible(false) end
	end
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if HL2CR_SkillsPoints() >= self.skilldata.cost and self.status == 1 then
			surface.PlaySound("items/suitchargeok1.wav")
			--net.Start("HL2CR_Skills_Purchase")
			--	net.WriteString(self.skillname)
			--net.SendToServer()
		elseif self.status < 2 then
			surface.PlaySound("items/suitchargeno1.wav")
		end
	end
end

function PANEL:Paint()
	if self:IsHovered() then
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.fontcolhi)
	else
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.fontcolout)
	end
	if self.status == 2 then
		draw.RoundedBox( 8, 2, 2, self:GetWide()-4, self:GetTall()-4, Theme.skill_2)
	elseif self.status == 1 then
		draw.RoundedBox( 8, 2, 2, self:GetWide()-4, self:GetTall()-4, Theme.skill_1)
	else
		draw.RoundedBox( 8, 2, 2, self:GetWide()-4, self:GetTall()-4, Theme.skill_0)
	end
	return true
end

vgui.Register( "QMenu_SkillPanel", PANEL, "Panel" )

-------------------------------------------------------------------------------------------------------
--Skills Tab-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( false )
	HL2CR_SkillPanel = self
end

function PANEL:Setup()
	local wide = self:GetWide()
	local tall = self:GetTall()

	self.SkillsPanel = New_ThemeVertScroll(self,tall * 0.02,tall * 0.02,wide - tall * 0.04,tall * 0.96)

	self.Skill = {}
	
	local maxy = 0 
	for k, v in pairs(HL2C_Skills.skills)do
		self.Skill[k] = vgui.Create("QMenu_SkillPanel",self.SkillsPanel)
		self.Skill[k]:Setup(k)
		if maxy < self.Skill[k]:GetY() then maxy = self.Skill[k]:GetY() end
	end
	self.SkillsPanel:UpdateMaxY(maxy + self.SkillsPanel:GetWide() * 0.2)
	
	self.SkillsPanel.PaintExtra = function()
		draw.NoTexture()
		surface.SetDrawColor( 30,30, 30, 255 )
		for k, v in pairs(self.Skill)do
			if HL2C_Skills.skills[v.skillname].required then
				for k2, v2 in pairs(HL2C_Skills.skills[v.skillname].required)do
					local xx,yy = v:GetCenter()
					local x2,y2 = self.Skill[v2]:GetCenter()
					DrawThickLine(xx,yy,x2,y2,4)
				end
			end
		end
		
	end

	
end

function PANEL:Refresh()
	for k, v in pairs(self.Skill)do
		v:Update()
	end
end


function PANEL:Paint()
	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.backcol2,false, false,true,true)
	return true
end

vgui.Register( "QMenu_Skills", PANEL, "Panel" )

function HL2C_Client:CreateSkills(parent)
	local element = vgui.Create("QMenu_Skills",parent)
	element:SetPos( 0, parent:GetTall() * 0.08)
	element:SetSize( parent:GetWide(), parent:GetTall() * 0.92 )
	element:Setup()
	return element
end