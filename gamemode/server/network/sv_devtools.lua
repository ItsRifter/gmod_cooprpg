net.Receive( "HL2C_DEV_AddCP", function( length, ply )
	if ( IsValid( ply ) and ply:IsPlayer() ) then
		local temptable = net.ReadTable()
		
		HL2C_Server:CreateCP(temptable.min,temptable.max,temptable.spawn,temptable.angle,nil)
		
	end
end )

net.Receive( "HL2C_DEV_DestroyCPs", function( length, ply )
	if ( IsValid( ply ) and ply:IsPlayer() ) then
		HL2C_Server:RemoveCPs()
	end
end )


