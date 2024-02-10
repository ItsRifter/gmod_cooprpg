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
		HL2C_Server:DebugMsg(Ent)
		--print("Name  " .. Ent:GetName())
		--print("Model " .. Ent:GetModel())
		--print("Pos " .. )
		--print("Angle " .. string.format("Angle(%d,%d,%d)", Ent:GetAngles():Unpack()))
		HL2C_Server:DebugMsg( string.format("Entity Name: %s | Model %s", Ent:GetName(), Ent:GetModel()) )
		HL2C_Server:DebugMsg("Position: %s | Angle: %s",
			string.format("Vector(%d,%d,%d)", Ent:GetPos():Unpack()), string.format("Angle(%d,%d,%d)", Ent:GetAngles():Unpack()
		))
		
		if IsValid(Ent:GetParent()) then HL2C_Server:DebugMsg( string.format("Parent", Ent:GetParent():GetName()) ) end
		
		print("HL2C_Server:CreateProp(\""..Ent:GetModel().."\","..string.format("Vector(%.1f,%.1f,%.1f)",Ent:GetPos():Unpack())..","..string.format("Angle(%.1f,%.1f,%.1f)",Ent:GetAngles():Unpack())..")")
	end
end)

--performs a deep ent scan, for finding anything like triggers.
concommand.Add("hl2c_scan", function(ply)
	if !ply:IsSuperAdmin() then return end
	local scan = ents.FindAlongRay( ply:EyePos(), ply:EyePos() + ply:EyeAngles():Forward() * 256)
	--PrintTable(scan)
	
	print("Index Class Name MapID")
	for i, ent in ipairs( scan ) do
		print(string.format( "[%03i] %-30s %-30s %i", i, ent:GetClass(), ent:GetName(),ent:MapCreationID()))
	end
end)