SWEP.Base = "weapon_base"

SWEP.PrintName = "Entity Box Vector Marker"
SWEP.Purpose = "Marks two points that makes a box"
SWEP.Instructions = "Left Click to mark first point\nRight click to mark second point\nReload to print Vector3's to console"

SWEP.ViewModel			    = "models/weapons/c_pistol.mdl"
SWEP.WorldModel			    = "models/weapons/w_pistol.mdl"

SWEP.Slot                   = 1
SWEP.SlotPos                = 0
SWEP.DrawCrosshair          = false
SWEP.DrawAmmo               = false

SWEP.HoldType               = "pistol"
SWEP.FiresUnderwater        = false

SWEP.Primary.Delay          = 0.1
SWEP.Primary.Automatic      = false 
SWEP.Primary.Ammo           = "none"

SWEP.Secondary.Delay        = 0.1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo	        = "none"

--local showHUD = showHUD or false	--dont believe this is needed

local p1 = Vector(0, 0, 0)
local p2 = Vector(0, 0, 0)

local minDist = 16
local maxDist = 256
local curDist = 128

function SWEP:DoTraceLine()
    local trace
    local aimAngle
    local filterEnt
    local owner

    if SERVER then
        owner = self:GetOwner()
    elseif CLIENT then
        owner = LocalPlayer()
    end
    
    trace = owner:EyePos()
    aimAngle = owner:GetAimVector() 

	local angle = Angle(0, 0, 0)
	
    local tr = util.TraceLine( {
		start = trace,
		endpos = trace + aimAngle * curDist,
		filter = owner
	} )

    return tr
end

function SWEP:Deploy()
    --showHUD = true
    return true
end

function SWEP:Holster()
    --showHUD = false
    return true
end

function SWEP:Think()
    local owner = self:GetOwner()
	
    local value = 1 

    if owner:KeyDown(IN_WALK) then
        value = value * 0.5
    end

    if owner:KeyDown(IN_DUCK) then
        curDist = curDist - value
    end

    if owner:KeyDown(IN_SPEED) then
        curDist = curDist + value
    end

    if owner:KeyPressed(IN_USE) then
        p1:Zero()
        p2:Zero()
    end

    curDist = math.Clamp(curDist, minDist, maxDist)
end

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end

    p1 = self:DoTraceLine().HitPos

    if CLIENT then 
        PlayUseSounds()
    end
end

function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end
    
    p2 = self:DoTraceLine().HitPos

    if CLIENT then 
        PlayUseSounds()
    end
end

function PlayUseSounds()
    surface.PlaySound("buttons/button15.wav")
end

local red = Color(255, 0, 0, 255)
local green = Color(0, 255, 0, 255)
local blue = Color(0, 0, 255, 255)
local orange = Color(255, 165, 0, 210)

function SWEP:CreateVectorAxis()
    local tr = self:DoTraceLine()
    local angle = Angle(0, 0, 0)
    local scale = 6

	local hitpos = tr.HitPos

	local forward 	= angle:Forward()
	local up 		= angle:Up()
	local left		= -angle:Right()

	if self:GetOwner():KeyDown(IN_WALK) then
		render.DrawLine( hitpos - 16 * forward, hitpos + 16 * forward, red, true )
		render.DrawLine( hitpos - 16 * forward + 08 * up, hitpos + 16 * forward + 08 * up, red, true )
		render.DrawLine( hitpos - 16 * forward + 16 * up, hitpos + 16 * forward + 16 * up, red, true )
		render.DrawLine( hitpos - 16 * forward - 08 * up, hitpos + 16 * forward - 08 * up, red, true )
		render.DrawLine( hitpos - 16 * forward - 16 * up, hitpos + 16 * forward - 16 * up, red, true )
		render.DrawLine( hitpos - 16 * forward + 16 * up, hitpos - 16 * forward - 16 * up, red, true )
		render.DrawLine( hitpos - 08 * forward + 16 * up, hitpos - 08 * forward - 16 * up, red, true )
		render.DrawLine( hitpos + 16 * forward + 16 * up, hitpos + 16 * forward - 16 * up, red, true )
		render.DrawLine( hitpos + 08 * forward + 16 * up, hitpos + 08 * forward - 16 * up, red, true )
		
		render.DrawLine( hitpos - 16 * left, hitpos + 16 * left, green, true )
		render.DrawLine( hitpos - 16 * left + 08 * up, hitpos + 16 * left + 08 * up, green, true )
		render.DrawLine( hitpos - 16 * left + 16 * up, hitpos + 16 * left + 16 * up, green, true )
		render.DrawLine( hitpos - 16 * left - 08 * up, hitpos + 16 * left - 08 * up, green, true )
		render.DrawLine( hitpos - 16 * left - 16 * up, hitpos + 16 * left - 16 * up, green, true )
		render.DrawLine( hitpos - 16 * left + 16 * up, hitpos - 16 * left - 16 * up, green, true )
		render.DrawLine( hitpos - 08 * left + 16 * up, hitpos - 08 * left - 16 * up, green, true )
		render.DrawLine( hitpos + 16 * left + 16 * up, hitpos + 16 * left - 16 * up, green, true )
		render.DrawLine( hitpos + 08 * left + 16 * up, hitpos + 08 * left - 16 * up, green, true )
		
		render.DrawLine( hitpos - 16 * up, hitpos + 16 * up, blue, true )
		render.DrawLine( hitpos - 16 * left + 08 * forward, hitpos + 16 * left + 08 * forward, blue, true )
		render.DrawLine( hitpos - 16 * left + 16 * forward, hitpos + 16 * left + 16 * forward, blue, true )
		render.DrawLine( hitpos - 16 * left - 08 * forward, hitpos + 16 * left - 08 * forward, blue, true )
		render.DrawLine( hitpos - 16 * left - 16 * forward, hitpos + 16 * left - 16 * forward, blue, true )
		render.DrawLine( hitpos - 16 * left + 16 * forward, hitpos - 16 * left - 16 * forward, blue, true )
		render.DrawLine( hitpos - 08 * left + 16 * forward, hitpos - 08 * left - 16 * forward, blue, true )
		render.DrawLine( hitpos + 16 * left + 16 * forward, hitpos + 16 * left - 16 * forward, blue, true )
		render.DrawLine( hitpos + 08 * left + 16 * forward, hitpos + 08 * left - 16 * forward, blue, true )
	else
		render.DrawLine( hitpos, hitpos + scale * forward, red, true )
		render.DrawLine( hitpos, hitpos + scale * left, green, true )
		render.DrawLine( hitpos, hitpos + scale * up, blue, true )
    end
end

function SWEP:DrawWireboxes()
    if p1:IsZero() and p2:IsZero() then return end
    local angle = Angle(0, 0, 0)

    local tempP1 = self:DoTraceLine().HitPos
    local tempP2 = tempP1	--no need to double trace same spot
    local boxPos = Vector(0,0,0)

    //TODO: Fix points as they are not correct from player eyetrace
    //maybe help Neko?
    //-ItsRifter
    
    if p1:IsZero() then
        --boxPos = (tempP1 + p2) / 2
        render.DrawWireframeBox(boxPos, angle, tempP1, p2, red, true)
    end

    if p2:IsZero() then
        --boxPos = (p1 + tempP2) / 2
        render.DrawWireframeBox(boxPos, angle, p1, tempP2, red, true)
    end
    
    if not p1:IsZero() and not p2:IsZero() then
        --boxPos = (p1 + p2) / 2
        render.DrawWireframeBox(boxPos, angle, p2, p1, orange, true)
    end

    //render.DrawWireframeBox(p1, angle, p1, )
    
end

hook.Add("PostDrawOpaqueRenderables", "yey", function()
    local wep = LocalPlayer():GetActiveWeapon()
	if !IsValid(wep) then return end
    if wep:GetClass() ~= "weapon_hl2c_boxmarker" then return end

    wep:CreateVectorAxis()
    wep:DrawWireboxes()
end)