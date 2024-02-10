HL2C_Ach.AchEarned = HL2C_Ach.AchEarned or {}
HL2C_Ach.AchProgress = HL2C_Ach.AchProgress or {}

local curNotifications = curNotifications or {}

--------------------------------
--------------------------------
local PANEL = {}

function PANEL:Init()
	self.achname = nil
end

function PANEL:Setup(achTbl, count)
	self:SetSize(ScrH() * 0.4 * HL2C_Client:Get_UIScale(),ScrH()* 0.1 * HL2C_Client:Get_UIScale())
	local wide = self:GetWide()
	local tall = self:GetTall()
	self:SetPos(ScrW() - wide, ScrH() + tall)
	self.count = count or false
	if achTbl.Secret then self.Secret = true end
	local icon = vgui.Create("DImage", self)
	icon:SetPos(tall*0.05, tall*0.05)
	icon:SetSize(tall*0.9, tall*0.9)
	icon:SetImage(achTbl.Mat)
	
	local Txt = New_ThemeText(self,tall, tall * 0.05,translate.Get(achTbl.Name),"Font2_Small",0,0)
	if !self.count then
		local txt = New_ThemeTextMulti(self,tall, tall * 0.4,translate.Get(achTbl.Desc),"Font2_Micro",0,0,2)
	else
		self.max = achTbl.Max
		local Txt = New_ThemeText(self,(tall+wide)*0.5, tall * 0.63,self.count.."/"..self.max,"Font2_Tiny",0.5,0)
	end

    table.insert(curNotifications, self)
	self:MoveTo(ScrW() - wide, ScrH() - (tall +1) * #curNotifications , 1, 0, 0.5, function()
		self:MoveTo(ScrW() - wide, ScrH() + tall, 4, 3, 2, function() 
            table.remove(curNotifications, #curNotifications)
			self:Remove()
		end)
	end)
end

function PANEL:Paint()
	local wide = self:GetWide()
	local tall = self:GetTall()
	draw.RoundedBox( 6, 0, 0, wide, tall, Theme.buttonout)
	
	if self.Secret then
		draw.RoundedBoxEx( 6, 2, 2, wide-4, tall * 0.32, Theme.secret1,true,true,false,false)
		draw.RoundedBoxEx( 6, 2, 2+tall * 0.32, wide-4, tall * 0.68-4, Theme.secret2,false,false,true,true)
	else
		draw.RoundedBoxEx( 6, 2, 2, wide-4, tall * 0.32, Theme.box,true,true,false,false)
		draw.RoundedBoxEx( 6, 2, 2+tall * 0.32, wide-4, tall * 0.68-4, Theme.box3,false,false,true,true)
	end
	if self.count then
		local size = math.floor((wide-tall-8)/self.max*self.count)
		draw.RoundedBox( 6, tall, tall * 0.6, wide-tall-8, tall * 0.3, Theme.buttonout)
		draw.RoundedBox( 6, tall, tall * 0.6, size, tall * 0.3, Theme.fontgreen)
	end

	return true
end
vgui.Register( "NewAchPanel", PANEL, "Panel" )

--------------------------------
--------------------------------

function HL2C_Ach:NewAchNotice(achTbl,count)
	local achPopUp = vgui.Create("NewAchPanel")
	achPopUp:Setup(achTbl,count)
	
	if not count then
		if not achRare then
			--surface.PlaySound("hl2cr/ach_unlock_new.wav")
		else
			--surface.PlaySound("hl2cr/rare_ach_unlock_new.wav")
		end
	else
		surface.PlaySound("ambient/levels/prison/radio_random11.wav")
	end
end

function HL2C_Ach:TestPopup(group,id,count)
	local ach = HL2C_Ach:GetAchievement(id,group)
	if not ach then return end
	HL2C_Ach:NewAchNotice(ach,count)
end


net.Receive( "HL2C_AchievementSend", function( length)
	local bytes = net.ReadUInt( 16 )
	local compressed = net.ReadData( bytes ) 
	local datajson = util.Decompress( compressed )

	HL2C_Ach.AchEarned = util.JSONToTable( datajson )
end )

net.Receive( "HL2C_AchievementProg", function( length)
	local bytes = net.ReadUInt( 16 )
	local compressed = net.ReadData( bytes ) 
	local datajson = util.Decompress( compressed )

	HL2C_Ach.AchProgress = util.JSONToTable( datajson )
end )

net.Receive("HL2C_AchievementEarned", function()
	--local group = net.ReadString()
	local id = net.ReadString()

	local ach = HL2C_Ach:GetAchievement(id)
	if not ach then return end
	
	HL2C_Ach:NewAchNotice(ach)
	table.insert(HL2C_Ach.AchEarned,id)
	if HL2C_Ach.AchProgress[id] then HL2C_Ach.AchProgress[id] = nil end

end)

net.Receive("HL2C_AchievementUpdate", function()
	--local group = net.ReadString()
	local id = net.ReadString()
	local count = net.ReadUInt(32)

	local ach = HL2C_Ach:GetAchievement(id)
	if not ach then return end
	
	HL2C_Ach:NewAchNotice(ach,count)
	if !HL2C_Ach.AchProgress[id] then
		HL2C_Ach.AchProgress[id] = 0
	end
	if ach.Interval then
		if math.floor(count/ach.Interval)-math.floor(HL2C_Ach.AchProgress[id]/ach.Interval) > 0 then
			HL2C_Ach:NewAchNotice(ach,count)
		end
	else
		HL2C_Ach:NewAchNotice(ach,count)
	end
	HL2C_Ach.AchProgress[id] = count
	--local achNotifyTbl = net.ReadTable()
	--AchUpdateNotice(achNotifyTbl)
end)

function HL2C_Ach:HasAchievement(ach)
	return table.HasValue( HL2C_Ach.AchEarned,ach)
end

function HL2C_Ach:GetProgress(ach)
	if HL2C_Ach.AchProgress[ach] then return HL2C_Ach.AchProgress[ach] end
	return 0
end