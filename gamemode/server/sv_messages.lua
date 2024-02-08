--local hl2c_player = FindMetaTable("Player")
function hl2c_player:SendMessage(...)
	HL2C_Server:SendMessage({...},self)
end

function hl2c_player:SendWarning(...)
	if self.LastWarn and self.LastWarn > CurTime() then return end
	HL2C_Server:SendMessage({...},self)
	self.LastWarn = CurTime() + 1
end

function HL2C_Server:SendMessageAll(...)
	local list = player.GetAll()
	HL2C_Server:SendMessage({...},list)
end

function HL2C_Server:SendMessageHuman(...)
	local list = HL2C_Global:GetHumans()
	HL2C_Server:SendMessage({...},list)
end

function HL2C_Server:SendMessageCombine(...)
	local list = HL2C_Global:GetCombine()
	HL2C_Server:SendMessage({...},list)
end

function HL2C_Server:SendMessage(text,players)
	local message = text
	if not istable(text) then message = {text} end
	
	net.Start("HL2C_ChatMessage")
		net.WriteTable(message)
	net.Send(players)
end