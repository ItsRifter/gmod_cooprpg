local VoteType = VoteType or 0
local VoteData = VoteData or nil
local VoteTime = VoteTime or nil

local timeleft = timeleft or 0

local Votes = Votes or {}
local YourVote = YourVote or 0


local PANEL = {}

local tex_tick = Material( "icon16/tick.png", "noclamp smooth" )
local tex_cross = Material( "icon16/cross.png", "noclamp smooth" )

local VTypes = {}

VTypes[VOTE_LOBBY] 		= "Vote_0"
VTypes[VOTE_RESTART] 	= "Vote_1"
VTypes[VOTE_NEXT]		= "Vote_2"
VTypes[VOTE_DIFF]		= "Vote_3"
VTypes[VOTE_CAMPAIGN]	= "Vote_4"

function PANEL:Init()
	local varH = ScrH() * 0.75 
	local varW = ScrW() * 0.15 * HL2C_Client:Get_UIScale()
	self:SetPos( 0, math.floor(ScrH()*0.1))
	self:SetSize( math.floor(varW), math.floor(varH) )
	
	--self:MakePopup()
	self.wide = self:GetWide()
	self.tall = self:GetTall()
	
	self:SetVisible( true )
	
	New_ThemeText(self,self.wide * 0.5, self.tall* 0.005,translate.Get(VTypes[VoteType]),"Font_Small",0.5,0)
	if VoteType > VOTE_NEXT then New_ThemeText(self,self.wide * 0.5, self.tall* 0.055,tostring(VoteData),"Font_Small",0.5,0) end
	
	local yes_img = vgui.Create("DImage", self)	-- Add image to Frame
	yes_img:SetPos(self.wide * 0.2, self.tall* 0.11)	-- Move it into frame
	yes_img:SetSize(self.wide * 0.1, self.wide * 0.1)	-- Size it to 150x150
	yes_img:SetMaterial(tex_tick)
	
	local no_img = vgui.Create("DImage", self)	-- Add image to Frame
	no_img:SetPos(self.wide * 0.7, self.tall* 0.11)	-- Move it into frame
	no_img:SetSize(self.wide * 0.1, self.wide * 0.1)	-- Size it to 150x150
	no_img:SetMaterial(tex_cross)
	
	New_ThemeText(self,self.wide * 0.125, self.tall* 0.105,"F1","Font_Small",0.5,0)
	New_ThemeText(self,self.wide * 0.875, self.tall* 0.105,"F2","Font_Small",0.5,0)
	
	self.timenum = New_ThemeText(self,self.wide * 0.5, self.tall* 0.105,0,"Font_Small",0.5,0)
	
	self.yesnum = New_ThemeText(self,self.wide * 0.125, self.tall* 0.145,0,"Font_Small",1,0)
	self.nonum = New_ThemeText(self,self.wide * 0.875, self.tall* 0.145,0,"Font_Small",0,0)
	
	
	--VoteType
end


---------------------------------------------------------------------------

local col_votetop = Color( 240, 140, 50, 200 )
local col_votetop2 = Color( 200, 120, 30, 160 )
local col_voteopti = Color( 20, 20, 20, 180 )
local col_voteyes = Color( 20, 160, 20, 180 )
local col_voteno  = Color( 160, 20, 20, 180 )

function PANEL:Paint()
	draw.RoundedBox( 10, 0, 0, self.wide, math.floor(self.tall * 0.1), col_voteopti)
	draw.RoundedBoxEx( 8, 2, 2, self.wide-4, math.floor(self.tall * 0.05)-2, col_votetop,true, true,false,false)
	draw.RoundedBoxEx( 8, 2, math.floor(self.tall * 0.05), self.wide-4, math.floor(self.tall * 0.05)-2, col_votetop2,false, false,true,true)

	--draw.RoundedBox( 8, math.floor(self.wide * 0.15), math.floor(self.tall * 0.105), math.floor(self.wide * 0.2), math.floor(self.wide * 0.12), col_voteopti)
	--draw.RoundedBox( 8, math.floor(self.wide * 0.65), math.floor(self.tall * 0.105), math.floor(self.wide * 0.2), math.floor(self.wide * 0.12), col_voteopti)

	if YourVote == 1 then 
		draw.RoundedBox( 8, math.floor(self.wide * 0.05), math.floor(self.tall * 0.105), math.floor(self.wide * 0.3), math.floor(self.wide * 0.12), col_voteyes)
		draw.RoundedBox( 8, math.floor(self.wide * 0.65), math.floor(self.tall * 0.105), math.floor(self.wide * 0.3), math.floor(self.wide * 0.12), col_voteopti)
	elseif YourVote == 2 then 
		draw.RoundedBox( 8, math.floor(self.wide * 0.05), math.floor(self.tall * 0.105), math.floor(self.wide * 0.3), math.floor(self.wide * 0.12), col_voteopti)
		draw.RoundedBox( 8, math.floor(self.wide * 0.65), math.floor(self.tall * 0.105), math.floor(self.wide * 0.3), math.floor(self.wide * 0.12), col_voteno)
	else
		draw.RoundedBox( 8, math.floor(self.wide * 0.05), math.floor(self.tall * 0.105), math.floor(self.wide * 0.3), math.floor(self.wide * 0.12), col_voteopti)
		draw.RoundedBox( 8, math.floor(self.wide * 0.65), math.floor(self.tall * 0.105), math.floor(self.wide * 0.3), math.floor(self.wide * 0.12), col_voteopti)
	end

	local newtimeleft = math.floor(VoteTime - CurTime()) + 1
	
	if timeleft != newtimeleft and newtimeleft >= 0 then
		timeleft = newtimeleft
		self.timenum:SetText(tostring(timeleft),nil, 0.5,0 )
	end

	return true
end

function PANEL:UpdateVotes()
	if self.Icons then
		for k,v in pairs(self.Icons)do
			v:Remove()
		end
	end
	
	self.Icons = {}
	
	local vote_yes = 0
	local vote_no = 0
	
	for k,v in pairs(Votes)	do
		local Icon = vgui.Create( "AvatarImage", self )
		Icon:SetSize( self.wide* 0.15, self.wide* 0.15 )
		if v == 1 then
			Icon:SetPos( self.wide*0.2, self.tall * 0.155 +  (self.wide * 0.16 * vote_yes) )
			vote_yes = vote_yes + 1
		else
			Icon:SetPos( self.wide*0.7, self.tall * 0.155 +  (self.wide * 0.16 * vote_no) )
			vote_no = vote_no + 1
		end
		
		Icon:SetPlayer( k, 32 )

		table.insert( self.Icons, Icon )
	end
	
	self.yesnum:SetText(tostring(vote_yes),nil, 1,0 )
	self.nonum:SetText(tostring(vote_no),nil, 0,0 )
end

vgui.Register( "Vote_Panel", PANEL, "Panel" )

function HL2C_Client:UpdateVotePanel()
	if not IsValid(HL2C_Client.VotePanel) then return end
	HL2C_Client.VotePanel:UpdateVotes()
end

function HL2C_Client:CreateVotePanel()
	if IsValid(HL2C_Client.VotePanel) then HL2C_Client:RemoveVotePanel() end
	HL2C_Client.VotePanel = vgui.Create( "Vote_Panel" )
end

function HL2C_Client:RemoveVotePanel()
	if IsValid(HL2C_Client.VotePanel) then HL2C_Client.VotePanel:Remove() end
end


net.Receive("HL2C_GV_VOTING", function()
	HL2C_Global.VOTING = net.ReadBool()
	if HL2C_Global.VOTING then
		VoteType = net.ReadUInt(4)
		VoteData = net.ReadString()
		VoteTime = net.ReadFloat()
		HL2C_Client:CreateVotePanel()
		YourVote = 0
	else
		HL2C_Client:RemoveVotePanel()
	end
end)

net.Receive("HL2C_VOTEDATA", function()
	Votes = net.ReadTable( false )
	HL2C_Client:UpdateVotePanel()
	if Votes[LocalPlayer()] then YourVote = Votes[LocalPlayer()] end
end)