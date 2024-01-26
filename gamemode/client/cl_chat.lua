function HL2C_Client:AddChatMessage( text )
	local message = {}
	
	for k, v in ipairs( text ) do	--translates things client side
		if isstring(v) then
			if string.StartsWith( v, "##" ) then
				local str = translate.Get(string.TrimLeft( v, "##" ))
				table.insert(message, str)
			else
				table.insert(message, v)
			end
		else
			table.insert(message, v)
		end
	end
	
	chat.AddText( unpack(message) )
end