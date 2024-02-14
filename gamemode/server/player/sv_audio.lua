function HL2C_Server:PlaySound(snd,pitch,ply)
	pitch = pitch or 100
	net.Start( "HL2C_PlaySnd" )
		net.WriteString( snd)
		net.WriteUInt(pitch,8)
	if not ply then net.Broadcast() else net.Send(ply) end
end

function hl2c_player:PlaySound(snd,pitch)
	pitch = pitch or 100
	HL2C_Server:PlaySound(snd,pitch,self)
end