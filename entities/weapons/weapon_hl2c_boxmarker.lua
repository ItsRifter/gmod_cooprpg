AddCSLuaFile()

SWEP.Base = "weapon_base"

SWEP.PrintName = "Entity Box Vector Marker"
SWEP.Purpose = "Marks two points that makes a box"
SWEP.Instructions = "Left Click to mark first point\nRight click to mark second point\nReload to print Vector3's to console"

SWEP.ViewModel			    = "models/weapons/c_pistol.mdl"
SWEP.WorldModel			    = "models/weapons/w_pistol.mdl"

SWEP.Slot                   = 1
SWEP.SlotPos                = 0
SWEP.DrawCrosshair          = true
SWEP.DrawAmmo               = false

SWEP.HoldType               = "pistol"
SWEP.FiresUnderwater        = false

SWEP.Primary.Delay          = 0.1
SWEP.Primary.Automatic      = false 
SWEP.Primary.Ammo           = "none"

SWEP.Secondary.Delay        = 0.1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo	        = "none"

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

local minDist = 1
local maxDist = 75

local dist = 30

local red = Color(255, 0, 0)
local green = Color(0, 255, 0)
local blue = Color(0, 0, 255)

local function CreateVectorAxis()
    local endPoint = LocalPlayer():GetEyeTrace().HitPos * 2

    print(LocalPlayer():GetEyeTrace().HitPos)

    local addVec = 25

    local xLine = endPoint + Vector(addVec, 0, 5)
    local YLine = endPoint + Vector(0, addVec, 5)
    local ZLine = endPoint + Vector(0, 0, addVec)

    render.DrawLine(endPoint, xLine, red)
    //debugoverlay.Axis(endPoint, Angle(0, 0, 0), 5, 1)
end