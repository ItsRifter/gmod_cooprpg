local hl2c_player = FindMetaTable("Player")

HL2C_Server.Vehicle_Current = HL2C_Server.Vehicle_Current or VEHC_NONE

function hl2c_player:SpawnVehicle(vehc_info)
	if not vehc_info then return end
	self:RemoveVehicle()	--shouldnt be needed but just incase

	local id = HL2C_Global:GetVehicleId(vehc_info.Model)

    local vehicle = ents.Create(vehc_info.Class)
    vehicle:SetModel(vehc_info.Model)
	
	if id == VEHC_AIRBOAT then
		vehicle:SetPos(self:FindSurface() + Vector(0, 0, 32) )
		vehicle:SetAngles(self:EyeAngles() - Angle(0, 90, 0))
	else
		vehicle:SetPos(self:GetPos() + Vector(0, 0, 50)	 )
		vehicle:SetAngles(self:EyeAngles() - Angle(0, 90, 0))
	end
    
    for i, key in pairs(vehc_info.KeyValues) do
        vehicle:SetKeyValue(i, key)
    end

    vehicle:Activate()
    vehicle:Fire( "addoutput", vehc_info.Target );
    vehicle:Spawn()
            
	
    vehicle:SetCustomCollisionCheck( true )
    
    self.vehicle = vehicle


	self.vehicle:SetOwner(self)
	self:EnterVehicle(self.vehicle)
	self:SetEyeAngles(Angle(0,90,0) )	--Sets players eyes to front of vehicle
	
	self.nextVehicle = CurTime() + 8
	--self:VehicleLights(vehc_info)	--WIP
end

function hl2c_player:VehicleLights(vehc_info)
	local vehicle = self.vehicle
	vehicle.light = ents.Create( "env_projectedtexture" )
	
	vehicle.light:SetParent( vehicle )
		
	-- The local positions are the offsets from parent..
	vehicle.light:SetLocalPos( Vector( 0, 20, 40 ) )
	
		
	-- Looks like only one flashlight can have shadows enabled!
	vehicle.light:SetKeyValue( "enableshadows", 0 )
	vehicle.light:SetKeyValue( "farz", 1800 )
	vehicle.light:SetKeyValue( "nearz", 12 )
	vehicle.light:SetKeyValue( "lightfov", 105 )
		
	local c = Color(255,255,255,255)
	local b = 2
	vehicle.light:SetKeyValue( "lightcolor", Format( "%i %i %i 255", c.r * b, c.g * b, c.b * b ) )
		
	vehicle.light:Spawn() 
	vehicle.light:SetLocalAngles( Angle(10,90,0))
	vehicle.light:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )

	--vehicle.light:Input( "TurnOff", NULL, NULL, "" )
end

function hl2c_player:RemoveVehicle()
	if not IsValid(self.vehicle) then return end

	if self:InVehicle() and self:GetVehicle() == self.vehicle then self:ExitVehicle() end
	self.vehicle:Remove()

	self.vehicle = nil
end

--function HL2C_Server:

function HL2C_Server:SetVehicle(id)
	if HL2C_Server.Vehicle_Current == id then return end
	if id == VEHC_NONE then 
		if CurTime() > 1 then
			--MSG Vehicles Disabled
			HL2C_Server:SendMessageAll(HL2R_TEXT_NORMAL,"##Vehicle_Disabled")
		end
		HL2C_Server.Vehicle_Current = id 
		return
	end
	local vehc_info = HL2C_Global:GetVehicleInfo(id)
	if not vehc_info then return end
	HL2C_Server:SendMessageAll(HL2R_TEXT_NORMAL,"##"..vehc_info.Name,"##Vehicle_Enabled")
	--MSG Vehicles Enabled
	HL2C_Server.Vehicle_Current = id
	HL2C_Server:SendVehicle()
end

function HL2C_Server:F3_Vehicle(ply)
	if IsValid(ply.vehicle) then			--Remove current vehicle
		if ply.LastVehicle and ply.LastVehicle > CurTime() then
			return	--prevent players fast removing new vehicles
		end
		ply:RemoveVehicle()
		ply.LastVehicle = CurTime() + 3
		return
	end

	if not ply:IsTeam(TEAM_HUMAN_ALIVE) then return end	--only alive human team can spawn vehicles

	if HL2C_Server.Vehicle_Current == VEHC_NONE then
	--	ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_Disabled"))
		ply:SendWarning(HL2R_TEXT_RED,"##Vehicle_Deny")
		return
	end
	
	if ply:InVehicle() then return end
	
	local vehc_info = HL2C_Global:GetVehicleInfo(HL2C_Server.Vehicle_Current)
	
	if not vehc_info then return end
	if ply.nextVehicle and ply.nextVehicle > CurTime() then
		--ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_TooFast"), tostring(math.Round(ply.nextSpawn - CurTime())))
		ply:SendWarning(HL2R_TEXT_RED,"##Vehicle_TooFast")
		return	--prevent players fast spawning new vehicles
	end
	
	ply:SpawnVehicle(vehc_info)

end

function GM:CanPlayerEnterVehicle( ply, vehicle, seat )
	local id = HL2C_Global:GetVehicleId(vehicle:GetModel())
	
	if not id then return true end

	if HL2C_Server.Vehicle_Current == VEHC_NONE then return false end
	
	return true
end

function HL2C_Server:SendVehicle(ply)
	net.Start( "HL2C_Vehicle" )
		 net.WriteUInt( HL2C_Server.Vehicle_Current, 4 )
	if not ply then net.Broadcast() else net.Send(ply) end
end

hook.Add("PlayerInitialSpawn", "HL2C_Sync_vehicle", function(ply)
	HL2C_Server:SendVehicle(ply)
end)