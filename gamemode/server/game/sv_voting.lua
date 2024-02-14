local VoteType = VoteType or 0
local VoteData = VoteData or nil
local VoteTime = VoteTime or nil

--type|	                    | Data
--  0 | Return to lobby		| nil
--  1 | Restart map			| nil
--  2 | Next map			| nil
--  3 | Change Difficulty	| integer = New difficulty 
--  4 | Start campaign		| string = campaign_ID

local T_VOTE_NAME = "TIMER_VOTING"
local T_VOTE_TIME = 30
local T_VOTE_POST = 10

local Votes = Votes or {}

local VTypes = {
	[VOTE_LOBBY] 	= {topass = 0.55, total = 0.7, minimum = 1},
	[VOTE_RESTART] 	= {topass = 0.55, total = 0.7, minimum = 1},
	[VOTE_NEXT] 	= {topass = 0.75, total = 0.7, minimum = 3},
	[VOTE_DIFF]		= {topass = 0.55, total = 0.6, minimum = 1},
	[VOTE_CAMPAIGN] = {topass = 0.55, total = 0.4, minimum = 1},
}

---------------------------------------------------------------------------------------

function HL2C_Server:FinishVote()
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "##Vote_Closed")
	timer.Create(T_VOTE_NAME, T_VOTE_POST, 1, function() 
		HL2C_Server:SetVoting(false)
		HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "##Vote_Ended")
	end)
	timer.Simple( 2, function() 
		HL2C_Server:CalculateVote()
	end  )
end

function HL2C_Server:CalculateVote()
	local total = 0
	local voted = 0
	local vote_yes = 0
	local vote_no = 0
	for _, ply in ipairs(player.GetAll()) do
		if IsMiscTeam(ply) or ply:IsBot() then continue end
		total = total + 1
		if Votes[ply] then
			voted = voted + 1
			if Votes[ply] == 1 then
				vote_yes = vote_yes + 1
			else
				vote_no = vote_no + 1
			end
		end
	end
	
	--HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, string.format("Yes %d / %d No",vote_yes,vote_no))
	--HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, string.format("Voted %d / %d",voted,total))
	
	local votepercent = 0
	if total > 0 then  votepercent = 1 / total * voted end
	if VTypes[VoteType].total > votepercent then --Not enough voters to pass
		HL2C_Server:SendMessageAll(HL2R_TEXT_RED, "NOT ENOUGH VOTED")
		return 
	end	
	if VTypes[VoteType].minimum > voted then	--Need more voters to pass
		HL2C_Server:SendMessageAll(HL2R_TEXT_RED, "NEED MORE VOTERS")
		return 
	end	
	local ratio = 1 / voted * vote_yes
	if VTypes[VoteType].topass > ratio then --Failed to pass threshhold
		HL2C_Server:SendMessageAll(HL2R_TEXT_RED, "FAILED TO PASS")
		return 
	end	
	
	HL2C_Server:SendMessageAll(HL2R_TEXT_GREEN, "VOTE PASSED")
end

---------------------------------------------------------------------------------------

function HL2C_Server:StartVote(vote_type,vote_data)
	if HL2C_Global:Voting() then return end
	if vote_type < 0 or vote_type > 4 then return end

	timer.Create(T_VOTE_NAME, T_VOTE_TIME, 1, function() HL2C_Server:FinishVote() end)

	VoteType = vote_type
	VoteData = vote_data or nil
	VoteTime = CurTime() + T_VOTE_TIME
	
	Votes = {}
	
	net.Start( "HL2C_VOTEDATA" )
		net.WriteTable( Votes, false )
	net.Broadcast()
	
	HL2C_Server:SetVoting(true)
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "##Vote_Start")
	
	HL2C_Server:PlaySound("common/stuck1.wav")
	
	if false then
		for _, bot in ipairs(player.GetBots()) do
			timer.Simple( math.Rand(3,10), function() 
				HL2C_Server:AddVote(bot,math.random( 1, 2 ))
			end  )
		end
	end
end

function HL2C_Server:StopVote()
	if not HL2C_Global:Voting() then return end
	
	if timer.Exists(T_VOTE_NAME) then timer.Remove(T_VOTE_NAME) end
	HL2C_Server:SetVoting(false)
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "##Vote_Stopped")
end

function hl2c_player:CallVote(vote_type,vote_data)
	if HL2C_Global:Voting() then self:SendMessage(HL2R_TEXT_RED, "##Vote_Deny") return end
	if HL2C_Global:MapWon() or HL2C_Global:MapFailed() then self:SendMessage(HL2R_TEXT_RED, "##Vote_Deny") return end
	if vote_type == VOTE_CAMPAIGN and HL2C_Server.LOBBY_MAP == game.GetMap() and not self:IsAdmin() then
		return
	end
	if not self:IsAdmin() and self.lastcalledcote and self.lastcalledcote > CurTime() then
		self:SendMessage(HL2R_TEXT_RED, "##Vote_Deny")
		return
	end
	
	self.lastcalledcote = CurTime() + 60
	HL2C_Server:StartVote(vote_type,vote_data)
end

---------------------------------------------------------------------------------------

function HL2C_Server:AddVote(ply,vote)
	if not HL2C_Global:Voting() then return end
	if VoteTime < CurTime() then return end	--Too late
	if IsMiscTeam(ply) then return end --No voting for you afks
	if vote < 1 or vote > 2 then return end
	if ply.lastvote and ply.lastvote > CurTime() then return end
	ply.lastvote = CurTime() + 2 --Prevent vote switching too quickly
	Votes[ply] = vote
	
	ply:PlaySound("common/wpn_hudoff.wav")
	
	net.Start( "HL2C_VOTEDATA" )
		net.WriteTable( Votes, false )
	net.Broadcast()
end

---------------------------------------------------------------------------------------
function HL2C_Server:SendVoting(ply)
	net.Start( "HL2C_GV_VOTING" )
		net.WriteBool( HL2C_Global.VOTING )
		
		if HL2C_Global.VOTING then
			net.WriteUInt(VoteType,4)
			net.WriteString(tostring(VoteData))
			net.WriteFloat(VoteTime)
		end
	if not ply then net.Broadcast() else net.Send(ply) end
end

function HL2C_Server:SetVoting(vote)
	if vote == HL2C_Global:Voting() then return end
	HL2C_Global.VOTING = vote
	HL2C_Server:SendVoting()
end

