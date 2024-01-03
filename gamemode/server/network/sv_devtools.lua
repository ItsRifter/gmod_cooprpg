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


