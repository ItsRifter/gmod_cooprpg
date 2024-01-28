--Only one can exist so moving them here
function GM:ShowHelp(ply)		--F1 Default
	--if HL2CR_Voting.State then 
	--	HL2CR_Voting:PlayerVote(ply, true)
	--else
		net.Start("HL2C_HelpMenu")
		net.Send(ply)
	--end
end

function GM:ShowTeam(ply)		--F2 Default
	--HL2CR_Voting:PlayerVote(ply, false)
end

function GM:ShowSpare1(ply)		--F3 Default
	HL2C_Server:F3_Vehicle(ply)
end

hook.Add( "StartCommand", "Command_Flashlight", function( ply, cmd )
	if cmd:GetImpulse() == 100 then
		if ply:InVehicle() and ply:GetVehicle() == ply.vehicle then
			ply:VehicleToggleLights()
			cmd:SetImpulse( 0 )		--used so the built in airboat lamp cant be enabled.
		end
	end
end )