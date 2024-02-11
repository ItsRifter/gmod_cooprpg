SUIT_FLASHLIGHT = {}

local flashlight_expense = 0.4
local expense_active = false

local isNearDepletion = false
local nearDepletion = 20
local reuseAfterRecharge = 22.5

function SUIT_FLASHLIGHT:DoTick(ply)
    if not ply.suit then return end

    if ply.suit.power >= reuseAfterRecharge and isNearDepletion then
        isNearDepletion = false
        ply:AllowFlashlight(true)
    end

    if ply.suit.power <= nearDepletion then
        isNearDepletion = true
        if not ply:FlashlightIsOn() then ply:AllowFlashlight(false) end
    end
    
    --Is flashlight turned on?
    expense_active = ply:FlashlightIsOn()
end

function SUIT_FLASHLIGHT:IsExpenseActive()
    return expense_active
end

function SUIT_FLASHLIGHT:DoExpense(ply)
    ply.suit.power = math.Clamp(ply.suit.power - flashlight_expense, 0, 100)

    if ply.suit.power < flashlight_expense then
        ply.suit.power = 0
        ply:Flashlight(false)
        ply:AllowFlashlight(false)
    end
end