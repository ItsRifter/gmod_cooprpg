
function HL2C_Server:CPTriggered(cp,ply)
	HL2C_Server:MoveSpawn(cp.TPPoint, cp.TPAngles, nil)
		
	if cp.lambda then cp.lambda:Remove() end

	PrintTable(player.GetAll())

	for i, pl in ipairs( player.GetAll() ) do
		if pl == ply then continue end
		if IsHuman(pl) then
			local curTeam = ply:Team()
			if pl:Team() == TEAM_HUMAN_FIN then continue end
			
			if pl:Team() == TEAM_HUMAN_DEAD then
				pl:Spawn()
			end
			
			pl:SetPos(cp.TPPoint)
			pl:SetEyeAngles(cp.TPAngles)
			pl:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		end
	end

end

function HL2C_Server:EndTriggered(cp,ply)
	ply:SetTeam(TEAM_HUMAN_FIN)
	ply:EmitSound("vo/k_lab/kl_excellent.wav", 100, 100)
	
	HL2C_Server:CheckFinished()
end


function HL2C_Server:CheckFinished()
	local total = 0
	local finished = 0
	for i, ply in ipairs( player.GetAll() ) do
		if IsHuman(ply) then
			total = total + 1
			if ply:Team() == TEAM_HUMAN_FIN then
				finished = finished+ 1
			end
		end
	end
	print(finished.."/"..total.." players finished the level")
end