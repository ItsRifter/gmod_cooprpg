--local hl2c_player = FindMetaTable("Player")

function HL2C_Server:SendNote(text,vector,colour,IType,players)
	if not IsValid(players) then return end
	net.Start( "HL2C_Indicator" )
		net.WriteString(text)	
		net.WriteVector(vector)
		net.WriteUInt(colour,7)	
		net.WriteUInt(IType,5)		
	net.Send(players)
end

function HL2C_Server:SendNoteAll(text,vector,colour,IType)
	HL2C_Server:SendNote(text,vector,colour,IType,player.GetAll())
end

function HL2C_Server:SendNoteRadius(text,vector,colour,IType,radius)
	local plist = {}
	local sqrad = radius * radius
	for _, p in pairs(player.GetAll()) do
		if p:GetPos():DistToSqr( vector) < sqrad then
			table.insert( plist, p )
		end
	end
	HL2C_Server:SendNote(text,vector,colour,IType,plist)
end

function hl2c_player:SendNote(text,vector,colour,IType)
	HL2C_Server:SendNote(text,vector,colour,IType,self)
end