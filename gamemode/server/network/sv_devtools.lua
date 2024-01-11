net.Receive( "HL2C_DEV_AddCP", function( length, ply )
	if ( IsValid( ply ) and ply:IsPlayer() ) then
		if !ply:IsSuperAdmin() then return end
		local temptable = net.ReadTable()
		HL2C_Server:CreateCP(temptable.min,temptable.max,temptable.spawn,temptable.angle,nil)
	end
end )

net.Receive( "HL2C_DEV_DestroyCPs", function( length, ply )
	if ( IsValid( ply ) and ply:IsPlayer() ) then
		if !ply:IsSuperAdmin() then return end
		HL2C_Server:RemoveCPs()
	end
end )


--reports entity being looked at
concommand.Add("hl2c_entinfo", function(ply)
	if !ply:IsSuperAdmin() then return end
	local Ent = ply:GetEyeTrace().Entity
	if IsValid(Ent) then
		print(Ent)
		print("Name  "..Ent:GetName())
		print("Model "..Ent:GetModel())
		if IsValid(Ent:GetParent()) then print("Parent "..Ent:GetParent():GetName()) end
	end
end)

--performs a deep ent scan, for finding anything like triggers.
concommand.Add("hl2c_scan", function(ply)
	if !ply:IsSuperAdmin() then return end
	local scan = ents.FindAlongRay( ply:EyePos(), ply:EyePos() + ply:EyeAngles():Forward() * 128)
	PrintTable(scan)
end)