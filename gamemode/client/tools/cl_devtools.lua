--HL2C_DebugTools
GM.HL2C_ToolMenu = GM.HL2C_ToolMenu or nil

local function HL2C_ToolOpen()
	if GAMEMODE.HL2C_ToolMenu then
		GAMEMODE.HL2C_ToolMenu:Remove()
	end

	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( ScrW() - 550, 50 ) 
	Frame:SetSize( 500, 900 ) 
	Frame:SetTitle( "HL2C Tools" ) 
	Frame:SetVisible( true ) 
	Frame:SetDraggable( true ) 
	Frame:ShowCloseButton( true ) 
	
	Frame.CornerA = Vector( 0, 0, 0 )

	Frame.ELabel = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel:SetPos( 100, 30 )
	Frame.ELabel:SetSize( 200, 30)
	Frame.ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerA:Unpack()) )

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Corner Red" )
	DButton:SetPos( 10, 30 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.CornerA = LocalPlayer():GetPos()
		Frame.ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerA:Unpack()) )
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 440, 30 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(Frame.ELabel:GetText())
	end
	
	Frame.CornerB = Vector( 0, 0, 0 )
	
	Frame.ELabel2 = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel2:SetPos( 100, 70 )
	Frame.ELabel2:SetSize( 200, 30)
	Frame.ELabel2:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerB:Unpack()) )	

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Corner Blue" )
	DButton:SetPos( 10, 70 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.CornerB = LocalPlayer():GetPos()
		Frame.ELabel2:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerB:Unpack()) )	
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 440, 70 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(Frame.ELabel2:GetText())
	end

	Frame.SpawnPos = Vector( 0, 0, 0 )
	Frame.SpawnAngle = Angle( 0, 0, 0 )

	Frame.ELabel3 = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel3:SetPos( 100, 110 )
	Frame.ELabel3:SetSize( 200, 30)
	Frame.ELabel3:SetText( string.format("Vector(%d,%d,%d)",Frame.SpawnPos:Unpack()) )	

	Frame.ELabel4 = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel4:SetPos( 310, 110 )
	Frame.ELabel4:SetSize( 100, 30)
	Frame.ELabel4:SetText( string.format("Angle(%d,%d,%d)",Frame.SpawnAngle:Unpack()) )	

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Spawn Pos" )
	DButton:SetPos( 10, 110 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.SpawnPos = LocalPlayer():GetPos()
		Frame.SpawnAngle = LocalPlayer():EyeAngles()
		Frame.ELabel3:SetText( string.format("Vector(%d,%d,%d)",Frame.SpawnPos:Unpack()) )	
		Frame.ELabel4:SetText( string.format("Angle(%d,%d,%d)",Frame.SpawnAngle:Unpack()) )	
	end

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 440, 110 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(Frame.ELabel3:GetText().." , "..Frame.ELabel4:GetText())
	end

	GAMEMODE.HL2C_ToolMenu = Frame
end

HL2C_DevTool = HL2C_DevTool or {}

function HL2C_DevTool:SetP1(vec)
	if !IsValid(GAMEMODE.HL2C_ToolMenu) then return end
	GAMEMODE.HL2C_ToolMenu.CornerA = vec
	GAMEMODE.HL2C_ToolMenu.ELabel:SetText( string.format("Vector(%d,%d,%d)",GAMEMODE.HL2C_ToolMenu.CornerA:Unpack()) )
end

function HL2C_DevTool:SetP2(vec)
	if !IsValid(GAMEMODE.HL2C_ToolMenu) then return end
	GAMEMODE.HL2C_ToolMenu.CornerB = vec
	GAMEMODE.HL2C_ToolMenu.ELabel2:SetText( string.format("Vector(%d,%d,%d)",GAMEMODE.HL2C_ToolMenu.CornerB:Unpack()) )
end

local function Draw_Tools()
	if IsValid(GAMEMODE.HL2C_ToolMenu) then
		--render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), GAMEMODE.HL2C_ToolMenu.CornerA, GAMEMODE.HL2C_ToolMenu.CornerB, Color( 255, 255, 255 ),false )
		
		if !GAMEMODE.HL2C_ToolMenu.CornerA:IsZero() then 
			render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), GAMEMODE.HL2C_ToolMenu.CornerA - Vector(4,4,4), GAMEMODE.HL2C_ToolMenu.CornerA + Vector(4,4,4), Color( 200, 50, 50 ),false )
		end
		if !GAMEMODE.HL2C_ToolMenu.CornerB:IsZero() then
			render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), GAMEMODE.HL2C_ToolMenu.CornerB - Vector(4,4,4), GAMEMODE.HL2C_ToolMenu.CornerB + Vector(4,4,4), Color( 50, 50, 200 ),false )
		end
		if !GAMEMODE.HL2C_ToolMenu.SpawnPos:IsZero() then
			render.DrawWireframeBox( GAMEMODE.HL2C_ToolMenu.SpawnPos, Angle(0,0,0), Vector(-16,-16,0), Vector(16,16,72), Color( 50, 500, 50 ),true )
			render.DrawLine( GAMEMODE.HL2C_ToolMenu.SpawnPos +Vector(-8,-8,0) , GAMEMODE.HL2C_ToolMenu.SpawnPos - Vector(-8,-8,0), Color( 50, 500, 50 ), true )
			render.DrawLine( GAMEMODE.HL2C_ToolMenu.SpawnPos +Vector(-8,08,0) , GAMEMODE.HL2C_ToolMenu.SpawnPos - Vector(-8,08,0), Color( 50, 500, 50 ), true )
		end
	end
end
hook.Add( "PreDrawEffects", "Draw_Tools", Draw_Tools )

--render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), Frame.CornerA, Frame.CornerB, Color( 255, 255, 255 ),false )



---------------------------------------------------------------------------------------------------------------------

concommand.Add( "hl2c_debugtool", function( ply, cmd, args )
	if not HL2C_DebugTools then return end
    print( "Opening debug tools" )
	HL2C_ToolOpen()
end ,nil,nil,1)

function GM:OnContextMenuOpen()
	gui.EnableScreenClicker( true )
end

function GM:OnContextMenuClose()
	gui.EnableScreenClicker( false )
end