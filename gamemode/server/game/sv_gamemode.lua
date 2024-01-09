
function HL2C_Server:CPTriggered(cp,ply)
	HL2C_Server:MoveSpawn(cp.TPPoint, cp.TPAngles, nil)
		
	if cp.lambda and cp.lambda:IsValid() then cp.lambda:Remove() end

	if cp.Func then cp:Func() end

	for i, pl in ipairs( player.GetAll() ) do
		if pl == ply then continue end
		if IsHuman(pl) then
			local curTeam = ply:Team()
			if pl:Team() == TEAM_HUMAN_FIN then continue end
			
			if pl:Team() == TEAM_HUMAN_DEAD then
				pl:Spawn()
				pl:SetPos(cp.TPPoint)
				pl:SetEyeAngles(cp.TPAngles)
				pl:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
			else
				local warp = true
				if cp.Dist then
					local range = cp.TPPoint:DistToSqr( pl:GetPos() )
					--print(pl:Name().." "..cp.Dist.." "..range)
					if range < cp.Dist then warp = false end
				end
				if warp then
					pl:SetPos(cp.TPPoint)
					pl:SetEyeAngles(cp.TPAngles)
					pl:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
				end
			end
			
		end
	end

end

function HL2C_Server:EndTriggered(cp,ply)
	ply:SetTeam(TEAM_HUMAN_FIN)
	ply:EmitSound("vo/k_lab/kl_excellent.wav", 100, 100)
	
	if !cp.Triggered then
		cp.Triggered = true
		if cp.Func then cp:Func() end
	end
	
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