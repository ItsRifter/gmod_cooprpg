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

---------------------------------------------------------------------------------------

function HL2C_Server:FinishVote()
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "The vote closed")
	timer.Create(T_VOTE_NAME, T_VOTE_POST, 1, function() 
		HL2C_Server:SetVoting(false)
		HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "The vote is over")
	end)
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
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "A vote started")
end

function HL2C_Server:StopVote()
	if not HL2C_Global:Voting() then return end
	
	if timer.Exists(T_VOTE_NAME) then timer.Remove(T_VOTE_NAME) end
	HL2C_Server:SetVoting(false)
	HL2C_Server:SendMessageAll(HL2R_TEXT_ORANGE, "A vote was stopped")
end

---------------------------------------------------------------------------------------

function HL2C_Server:AddVote(ply,vote)
	if not HL2C_Global:Voting() then return end
	if VoteTime < CurTime() then return end	--Too late
	if IsMiscTeam(ply) then return end --No voting for you afks
	if ply.lastvote and ply.lastvote > CurTime() then return end
	ply.lastvote = CurTime() + 2 --Prevent vote switching too quickly
	Votes[ply] = vote
	
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

