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
	Frame:SetAlpha(200)
	Frame:SetDraggable( true ) 
	Frame:ShowCloseButton( true ) 
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Give boxmaker" )
	DButton:SetPos( 10, 30 )
	DButton:SetSize( 200, 30 )
	DButton.DoClick = function()				
		LocalPlayer():ConCommand( "give weapon_hl2c_boxmarker" )
	end
	
	Frame.grid = false
	
	local DCheckbox = vgui.Create( "DCheckBoxLabel", Frame ) -- Create the checkbox
	DCheckbox:SetPos( 230, 40 )						-- Set the position
	DCheckbox:SetText("Grid")					-- Set the text next to the box
	DCheckbox:SetValue( false )						-- Initial value
	DCheckbox:SizeToContents()						-- Make its size the same as the contents
	DCheckbox.OnChange = function()
		Frame.grid = DCheckbox:GetChecked()
	end
	
	Frame.CornerA = Vector( 0, 0, 0 )

	Frame.ELabel = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel:SetPos( 100, 70 )
	Frame.ELabel:SetSize( 200, 30)
	Frame.ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerA:Unpack()) )

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Corner Red" )
	DButton:SetPos( 10, 70 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.CornerA = LocalPlayer():GetPos()
		Frame.ELabel:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerA:Unpack()) )
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 440, 70 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(Frame.ELabel:GetText())
	end
	
	Frame.CornerB = Vector( 0, 0, 0 )
	
	Frame.ELabel2 = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel2:SetPos( 100, 110 )
	Frame.ELabel2:SetSize( 200, 30)
	Frame.ELabel2:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerB:Unpack()) )	

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Corner Blue" )
	DButton:SetPos( 10, 110 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.CornerB = LocalPlayer():GetPos()
		Frame.ELabel2:SetText( string.format("Vector(%d,%d,%d)",Frame.CornerB:Unpack()) )	
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 440, 110 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(Frame.ELabel2:GetText())
	end

	Frame.SpawnPos = Vector( 0, 0, 0 )
	Frame.SpawnAngle = Angle( 0, 0, 0 )

	Frame.ELabel3 = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel3:SetPos( 100, 150 )
	Frame.ELabel3:SetSize( 200, 30)
	Frame.ELabel3:SetText( string.format("Vector(%d,%d,%d)",Frame.SpawnPos:Unpack()) )	

	Frame.ELabel4 = vgui.Create( "DTextEntry", Frame  )
	Frame.ELabel4:SetPos( 310, 150 )
	Frame.ELabel4:SetSize( 100, 30)
	Frame.ELabel4:SetText( string.format("Angle(%d,%d,%d)",Frame.SpawnAngle:Unpack()) )	

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Spawn Pos" )
	DButton:SetPos( 10, 150 )
	DButton:SetSize( 70, 30 )
	DButton.DoClick = function()				
		Frame.SpawnPos = LocalPlayer():GetPos()
		Frame.SpawnAngle = LocalPlayer():EyeAngles()
		Frame.ELabel3:SetText( string.format("Vector(%d,%d,%d)",Frame.SpawnPos:Unpack()) )	
		Frame.ELabel4:SetText( string.format("Angle(%d,%d,%d)",Frame.SpawnAngle:Unpack()) )	
	end

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy" )
	DButton:SetPos( 440, 150 )
	DButton:SetSize( 50, 30 )
	DButton.DoClick = function()				
		 SetClipboardText(Frame.ELabel3:GetText().." , "..Frame.ELabel4:GetText())
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Create CP" )
	DButton:SetPos( 10, 190 )
	DButton:SetSize( 200, 30 )
	DButton.DoClick = function()	
		local temptable = {}
		temptable.min = Frame.CornerA
		temptable.max = Frame.CornerB
		temptable.spawn = Frame.SpawnPos
		temptable.angle = Frame.SpawnAngle
		net.Start( "HL2C_DEV_AddCP" )
			net.WriteTable( temptable, false )
		net.SendToServer()
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Remove All CPs" )
	DButton:SetPos( 340, 190 )
	DButton:SetSize( 150, 30 )
	DButton.DoClick = function()	
		local temptable = {}
		temptable.min = Frame.CornerA
		temptable.max = Frame.CornerB
		temptable.spawn = Frame.SpawnPos
		temptable.angle = Frame.SpawnAngle
		net.Start( "HL2C_DEV_DestroyCPs" )
		net.SendToServer()
	end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy CP Code to clipboard" )
	DButton:SetPos( 10, 600 )
	DButton:SetSize( 480, 30 )
	DButton.DoClick = function()
		local clipboard = "{ min="..string.format("Vector(%.1f,%.1f,%.1f)",Frame.CornerA:Unpack())
		clipboard = clipboard..",max="..string.format("Vector(%.1f,%.1f,%.1f)",Frame.CornerB:Unpack())
		clipboard = clipboard..",spawn="..string.format("Vector(%.1f,%.1f,%.1f)",Frame.SpawnPos:Unpack())
		clipboard = clipboard..",angle="..string.format("Angle(%.1f,%.1f,%.1f)",Frame.SpawnAngle:Unpack())
		clipboard = clipboard..", func = nil },"
		SetClipboardText(clipboard)
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy Exit/Trigger Code to clipboard" )
	DButton:SetPos( 10, 640 )
	DButton:SetSize( 480, 30 )
	DButton.DoClick = function()
		local clipboard = "{ min="..string.format("Vector(%.1f,%.1f,%.1f)",Frame.CornerA:Unpack())
		clipboard = clipboard..",max="..string.format("Vector(%.1f,%.1f,%.1f)",Frame.CornerB:Unpack())
		clipboard = clipboard..", func = nil }"
		SetClipboardText(clipboard)
	end
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy Spawn Code to clipboard" )
	DButton:SetPos( 10, 680 )
	DButton:SetSize( 480, 30 )
	DButton.DoClick = function()
		local clipboard = "{ spawn="..string.format("Vector(%.1f,%.1f,%.1f)",Frame.SpawnPos:Unpack())
		clipboard = clipboard..",angle="..string.format("Angle(%.1f,%.1f,%.1f)",Frame.SpawnAngle:Unpack()).."}"
		SetClipboardText(clipboard)
	end
	
	
	local DButton = vgui.Create( "DButton", Frame )
	DButton:SetText( "Copy Display lua to clipboard" )
	DButton:SetPos( 10, 760 )
	DButton:SetSize( 480, 30 )
	DButton.DoClick = function()

		local clipboard = "HL2C_Server:CreateInfoboard("..string.format("Vector(%.1f,%.1f,%.1f)",LocalPlayer():EyePos():Unpack())
		clipboard = clipboard..","..string.format("Angle(%.1f,%.1f,%.1f)",LocalPlayer():EyeAngles():Unpack())..",64,32,\"Text\")"
		SetClipboardText(clipboard)
	end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

	GAMEMODE.HL2C_ToolMenu = Frame
end

HL2C_DevTool = HL2C_DevTool or {}

function HL2C_DevTool:SetP1(vec)
	if !IsValid(GAMEMODE.HL2C_ToolMenu) then return end
	GAMEMODE.HL2C_ToolMenu.CornerA = Vector(vec)
	GAMEMODE.HL2C_ToolMenu.ELabel:SetText( string.format("Vector(%d,%d,%d)",GAMEMODE.HL2C_ToolMenu.CornerA:Unpack()) )
end

function HL2C_DevTool:SetP2(vec)
	if !IsValid(GAMEMODE.HL2C_ToolMenu) then return end
	GAMEMODE.HL2C_ToolMenu.CornerB = Vector(vec)
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
			local pos = GAMEMODE.HL2C_ToolMenu.SpawnPos
			render.DrawWireframeBox( pos, Angle(0,0,0), Vector(-16,-16,0), Vector(16,16,72), Color( 50, 220, 50 ),true )
			render.DrawLine( pos +Vector(-8,-8,0) , pos - Vector(-8,-8,0), Color( 50, 220, 50 ), true )
			render.DrawLine( pos +Vector(-8,08,0) , pos - Vector(-8,08,0), Color( 50, 220, 50 ), true )
			
			pos = pos +Vector(0,0,64)
			
			--I spend far too long on this
			
			local vec1 = Angle(GAMEMODE.HL2C_ToolMenu.SpawnAngle)
			vec1:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Up(), 25)
			vec1:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Right(), 15)
			local vec2 = Angle(GAMEMODE.HL2C_ToolMenu.SpawnAngle)
			vec2:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Up(), -25)
			vec2:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Right(), 15)
			local vec3 = Angle(GAMEMODE.HL2C_ToolMenu.SpawnAngle)
			vec3:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Up(), -25)
			vec3:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Right(), -15)
			local vec4 = Angle(GAMEMODE.HL2C_ToolMenu.SpawnAngle)
			vec4:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Up(), 25)
			vec4:RotateAroundAxis( GAMEMODE.HL2C_ToolMenu.SpawnAngle:Right(), -15)
			
			local pos1 = pos + vec1:Forward() * 32
			local pos2 = pos + vec2:Forward() * 32
			local pos3 = pos + vec3:Forward() * 32
			local pos4 = pos + vec4:Forward() * 32
			--render.DrawLine( pos , pos + GAMEMODE.HL2C_ToolMenu.SpawnAngle:Forward() * 16, Color( 50, 220, 50 ), true )
			render.DrawLine( pos ,pos1, Color( 50, 220, 50 ), true )
			render.DrawLine( pos ,pos2, Color( 50, 220, 50 ), true )
			render.DrawLine( pos ,pos3, Color( 50, 220, 50 ), true )
			render.DrawLine( pos ,pos4, Color( 50, 220, 50 ), true )
			
			render.DrawLine( pos1 ,pos2, Color( 50, 220, 50 ), true )
			render.DrawLine( pos2 ,pos3, Color( 50, 220, 50 ), true )
			render.DrawLine( pos3 ,pos4, Color( 50, 220, 50 ), true )
			render.DrawLine( pos4 ,pos1, Color( 50, 220, 50 ), true )

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