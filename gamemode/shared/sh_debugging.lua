//INTENDED FOR DEVELOPER DEBUGGING, YOU MAY USE THIS FOR ERROR/WARNING MESSAGES

HL2C_COLOR_GREEN = Color(0, 215, 0)
HL2C_COLOR_RED = Color(170, 0, 0, 175)
HL2C_COLOR_ORANGE = Color(255, 185, 0)
HL2C_COLOR_STANDARD = Color(238, 255, 0)

HL2C_DEBUG_STANDARD = 0
HL2C_DEBUG_SUCCESS = 1
HL2C_DEBUG_FAILED = 2
HL2C_DEBUG_WARNING = 3

HL2C_DEBUG_CLIENT_CENTERPRINT = 0
HL2C_DEBUG_CLIENT_CONSOLE = 1
HL2C_DEBUG_CLIENT_CHATBOX = 2
HL2C_DEBUG_CLIENT_CHAT_CONSOLE = 3

local function GetDebugColor(intMsgType)
    if intMsgType == 0 then return HL2C_COLOR_GREEN end
    if intMsgType == 1 then return HL2C_COLOR_RED end
    if intMsgType == 2 then return HL2C_COLOR_ORANGE end

    return HL2C_COLOR_STANDARD
end

if SERVER then
    
    //Make a debug message
    function HL2C_Server:DebugMsg(strMsg, intColour)
        //In case one of us forgot to leave a message
        if !IsValid(strMsg) then
            MsgC(HL2C_COLOR_RED, "HL2C-DEBUG-FAIL: Tried to print with no message \n")
            return
        end

        //Default colour type to 0 if none exist
        if intColour == nil then intColour = 0 end

        MsgC(GetDebugColor(intColour), "HL2C-DEBUG: " .. strMsg .. "\n")
    end

    //Prints a debug message from a table
    //!--Specify any colours in the table in order--!
    function HL2C_Server:DebugCustomMsg(tblMsg)
        //If table is not proper or is empty, stop here
        if not istable(tblMsg) or table.IsEmpty(tblMsg) then 
            MsgC(HL2C_COLOR_RED, "HL2C-DEBUG-FAIL: Tried to print an invalid or empty table \n")
            return 
        end

        MsgC("HL2C-DEBUG:" .. unpack(tblMsg) .. "\n")
    end
end

if CLIENT then
    function HL2C_Client:DebugMsg(strMsg, intColour, intDisplay)
        if intDisplay == nil then intDisplay = 0 end

        if intDisplay ~= HL2C_DEBUG_CLIENT_CHATBOX then
            if intColour == nil then intColour = 0 end
            chat.AddText(GetDebugColor(intColour), strMsg)
        else
            LocalPlayer():PrintMessage(MatchEnumHUD(intDisplay), strMsg)
        end
    end

    function HL2C_Client:AddToChatbox(tblMsg)
        if not istable(tblMsg) or table.IsEmpty(tblMsg) then return end
        
        chat.AddText(unpack(tblMsg))
    end

    local function MatchEnumHUD(intColour)
        if intColour == 0 then return HUD_PRINTCENTER end
        if intColour == 1 then return HUD_PRINTCONSOLE end
        if intColour == 3 then return HUD_PRINTTALK end

        //return intType as is if above checks were false
        return intType
    end
end