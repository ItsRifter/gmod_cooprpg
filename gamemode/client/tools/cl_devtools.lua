--HL2C_DebugTools
GM.HL2C_ToolMenu = HL2C_ToolMenu or nil

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

	local ELabel = vgui.Create( "DTextEntry", Frame  )
	ELabel:SetPos( 100, 30 )
	ELabel:SetSize( 200, 30)
	ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerA:Unpack()) )

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Corner Red" )
	DButton:SetPos( 10, 30 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.CornerA = LocalPlayer():GetPos()
		ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerA:Unpack()) )
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 420, 30 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(ELabel:GetText())
	end
	
	Frame.CornerB = Vector( 0, 0, 0 )
	
	local ELabel = vgui.Create( "DTextEntry", Frame  )
	ELabel:SetPos( 100, 70 )
	ELabel:SetSize( 200, 30)
	ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerB:Unpack()) )	

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Corner Blue" )
	DButton:SetPos( 10, 70 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.CornerB = LocalPlayer():GetPos()
		ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerB:Unpack()) )	
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 420, 70 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(ELabel:GetText())
	end

	GAMEMODE.HL2C_ToolMenu = Frame
end

function Draw_Tools()
	if IsValid(GAMEMODE.HL2C_ToolMenu) then
		render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), GAMEMODE.HL2C_ToolMenu.CornerA, GAMEMODE.HL2C_ToolMenu.CornerB, Color( 255, 255, 255 ),false )
		
		render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), GAMEMODE.HL2C_ToolMenu.CornerA - Vector(4,4,4), GAMEMODE.HL2C_ToolMenu.CornerA + Vector(4,4,4), Color( 200, 50, 50 ),false )
		render.DrawWireframeBox( Vector(0,0,0), Angle(0,0,0), GAMEMODE.HL2C_ToolMenu.CornerB - Vector(4,4,4), GAMEMODE.HL2C_ToolMenu.CornerB + Vector(4,4,4), Color( 50, 50, 200 ),false )
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