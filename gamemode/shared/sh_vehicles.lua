--shared so client can use references

VEHC_NONE 			= 0
VEHC_AIRBOAT 		= 1
VEHC_AIRBOAT_GUN	= 2
VEHC_JEEP 			= 3
VEHC_JALOPY 		= 4


local Vehicles = {}
Vehicles[VEHC_AIRBOAT]={
	Name = "Vehicle_Airboat",
	Class = "prop_vehicle_airboat",
	Model = "models/airboat.mdl",
	Target = "targetname airboat",
	KeyValues = {
		vehiclescript = "scripts/vehicles/airboat.txt",
		EnableGun = 0
	}
}

Vehicles[VEHC_AIRBOAT_GUN]={
	Name = "Vehicle_Airboat",
	Class = "prop_vehicle_airboat",
	Model = "models/airboat.mdl",
	Target = "targetname airboat",
	KeyValues = {
		vehiclescript = "scripts/vehicles/airboat.txt",
		EnableGun = 1
	}
}

Vehicles[VEHC_JEEP]={
	Name = "Vehicle_Jeep",
	Class = "prop_vehicle_jeep_old",
	Model = "models/buggy.mdl",
	Target = "targetname jeep",
	KeyValues = {
		vehiclescript = "scripts/vehicles/jeep_test.txt",
		EnableGun = 1
	}
}

Vehicles[VEHC_JALOPY]={
	Name = "Vehicle_Jalopy",
	Class = "prop_vehicle_jeep_old",
	Model = "models/vehicle.mdl",
	Target = "targetname jalopy",
	KeyValues = {
		vehiclescript = "scripts/vehicles/jalopy.txt",
	}
}

function HL2C_Global:GetVehicleInfo(id)
	return Vehicles[id] or nil
end

local mdl_list = {}
mdl_list["models/airboat.mdl"] 	= VEHC_AIRBOAT
mdl_list["models/buggy.mdl"] 	= VEHC_JEEP
mdl_list["models/vehicle.mdl"] 	= VEHC_JALOPY

function HL2C_Global:GetVehicleId(mdl)
	return mdl_list[mdl] or VEHC_NONE
end