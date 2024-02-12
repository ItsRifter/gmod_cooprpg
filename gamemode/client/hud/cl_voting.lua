local VoteType = VoteType or 0
local VoteData = VoteData or nil
local VoteTime = VoteTime or nil

net.Receive("HL2C_GV_VOTING", function()
	HL2C_Global.VOTING = net.ReadBool()
	if HL2C_Global.VOTING then
		VoteType = net.ReadUInt(4)
		VoteData = net.ReadString()
		VoteTime = net.ReadFloat()
	end
end)