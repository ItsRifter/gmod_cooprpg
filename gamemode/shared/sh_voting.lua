VOTE_LOBBY 		= 0
VOTE_RESTART 	= 1
VOTE_NEXT		= 2
VOTE_DIFF		= 3
VOTE_CAMPAIGN	= 4

local Vote_Data = {
	[0] = {name = "HL2", desc = "Vote_HL2",map = "d1_trainstation_01"},
}

function HL2C_Global:GetVoteData(num)
	if Vote_Data[num] then return Vote_Data[num] end
	return nil
end

function HL2C_Global:GetVoteNum(name)
	name = string.lower( name)
	for k, v in pairs(Vote_Data) do
		if name == string.lower( v.name) then return k end
	end
	return nil
end