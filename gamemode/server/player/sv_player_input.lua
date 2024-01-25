--Only one can exist so moving them here
function GM:ShowHelp(ply)
	--if HL2CR_Voting.State then 
	--	HL2CR_Voting:PlayerVote(ply, true)
	--else
		net.Start("HL2C_HelpMenu")
		net.Send(ply)
	--end
end

function GM:ShowTeam(ply)
	--HL2CR_Voting:PlayerVote(ply, false)
end

function GM:ShowSpare1(ply)
	HL2C_Server:F3_Vehicle(ply)
end