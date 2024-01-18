include('shared.lua')

ENT.RenderGroup = RENDERGROUP_OPAQUE;

function ENT:DrawText ( text, font, x, y, color, xalign, yalign )
	surface.SetFont(font);
	local W, H = surface.GetTextSize(text);
	
	if yalign == 1 then
		y = y - (H * .5);
	elseif yalign == 2 then
		y = y - H;
	end
	
	if xalign == 1 then
		x = x - (W * .5);
	elseif xalign == 2 then
		x = x - W;
	end
	
	draw.DrawText(text, font, self.X + x, self.Y + y, color);
end

function ENT:DrawRect ( x, y, w, h, color )
	surface.SetDrawColor(color.r, color.g, color.b, color.a);
	surface.DrawRect(self.X + x, self.Y + y, w, h);
end

surface.CreateFont( "3DInfoboard", 
{
		font    = "Trebuchet",
		size    = 28,
		weight  = 600,
		antialias = true,
		shadow = false
})


function ENT:Draw()		
	if !self.Setup then
		return false;
	end
	
	cam.Start3D2D(self:GetPos(), self.RenderAngle, 1 / self.Scale)
		self:DrawRect(0, 0, self.W, self.H, Color(0, 0, 0, 100));

		if self.Text then
			self:DrawText(self.Text , "3DInfoboard", self.W * 0.5 , self.H * 0.5, Color(220 , 220 , 220, 200), 1, 1);
		end
		--self:DrawText(CurrentMap.author , "3DScoreboardSmall", self.W -100 , 244, Color(40 , 40 , 40, 255), 1, 0);
		
	cam.End3D2D()
	
end

function ENT:Initialize ( )
	self.Setup = false;
end

function ENT:Think()
	if !self.Setup and self:GetNetworkedVector("OBB_Max") and self:GetNetworkedVector("OBB_Max") != Vector(0, 0, 0) then
		self.Setup = true;
		
		self.OBBMax = self:GetNetworkedVector("OBB_Max");
		self.OBBMin = self:GetNetworkedVector("OBB_Min");
		self.Text = self:GetNetworkedVector("Text");
		self.Text = translate.Get(self.Text)
			
		self.YDist = self.OBBMax:Distance(Vector(self.OBBMax.x, self.OBBMax.y, self.OBBMin.z));
		self.XDist = self.OBBMax:Distance(Vector(self.OBBMin.x, self.OBBMin.y, self.OBBMax.z));
			
		self.Scale = 2;
		
		if self.XDist < 400 then self.Scale = 3 end
		if self.XDist > 550 then self.Scale = 1.6 end
		if self.XDist > 750 then self.Scale = 1.2 end
		if self.XDist > 1000 then self.Scale = 0.8 end
		if self.XDist > 1200 then self.Scale = 0.6 end
		
		if self.YDist < 200 and self.Scale < 2 then self.Scale = 2 end
		
		self.X = self.XDist * -(self.Scale * .5);
		self.Y = self.YDist * -(self.Scale * .5);
		self.W = self.XDist * self.Scale;
		self.H = self.YDist * self.Scale;
		
		--32 + 22 per line self.H - 64
		--self.MaxLines = math.floor((self.H - 96)/ 22)
		
		--local ang = self:GetAngles()
		--local newang = Angle(ang.pitch + 11.25 - (ang.pitch + 11.25) %22.5,ang.yaw + 11.25 - (ang.yaw+ 11.25) %22.5,ang.roll + 11.25 - (ang.roll+ 11.25) %22.5)
		self.RenderAngle = self:GetAngles()
		self.RenderAngle:RotateAroundAxis(self.RenderAngle:Right(), -90)
		self.RenderAngle:RotateAroundAxis(self.RenderAngle:Up(), 90)
		
		self:SetRenderBoundsWS(self.OBBMax, self.OBBMin,Vector(32,32,32));
		
	end
end

function ENT:DrawTranslucent() self:Draw(); end
function ENT:BuildBonePositions( NumBones, NumPhysBones ) end
function ENT:SetRagdollBones( bIn ) self.m_bRagdollSetup = bIn; end
function ENT:DoRagdollBone( PhysBoneNum, BoneNum ) end
