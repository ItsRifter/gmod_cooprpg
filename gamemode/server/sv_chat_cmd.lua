local chat_cmds = {
	["!lobby"] = function(ply, command)
		ply:CallVote(VOTE_LOBBY, nil)
	end,
	["!restart"] = function(ply, command)
		ply:CallVote(VOTE_RESTART, nil)
	end,
	["!skipmap"] = function(ply, command)
		ply:CallVote(VOTE_NEXT, nil)
	end,
	["!diff"] = function(ply, command)
		if command[2] then
			local diff = tonumber(command[2])
			if diff then
				if diff >=0 and diff <=4 then ply:CallVote(VOTE_DIFF, diff) end
			else
				--not a number
			end
		else
			--return current difficulty
		end
		
	end,
	["!campaign"] = function(ply, command)
		local votenum = HL2C_Global:GetVoteNum(command[2])
		if votenum then
			ply:CallVote(VOTE_CAMPAIGN, votenum)
		else	--campaign not valid
		
		end
	end,

	["!endvote"] = function(ply, command)
		if ply:IsAdmin() then HL2C_Server:StopVote() end
	end,
}


hook.Add("PlayerSay", "HL2C_ChatCmds", function(ply, text)
    --if the first letter is not an !, stop here
    if text[1] ~= "!" then return end

    local command = string.lower(text)
    command = string.Split(command, " ")
	cmd = command[1]

    if chat_cmds[cmd] then
        chat_cmds[cmd](ply, command)
		return ""
    end

    return ""
end)