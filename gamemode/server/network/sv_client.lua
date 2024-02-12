
net.Receive("HL2C_Model_Update", function(len, ply)
	if not ply then return end

	local mdl = HL2C_Global:GetModelFromName(net.ReadString(),net.ReadString(),HL2C_Global:GetLvlAccess(ply))
	if mdl then ply:UpdateModelNetwork(mdl) end
end)