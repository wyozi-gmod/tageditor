
wyozite.COLOR_WHITE = Color(255, 255, 255)

hook.Add("TTTScoreboardColumns", "WyoziTEAddColumn", function(pnl)
	pnl:AddColumn(wyozite.TagColumnName, function(ply, label)
		if not IsValid(ply) then return "" end

		local v, v2 = ply:GetNWVector("wte_sbtclr"), ply:GetNWVector("wte_sbtclr2")
		local clr = wyozite.COLOR_WHITE
		local clr2
		if v and (v.x ~= 0 or v.y ~= 0 or v.z ~= 0) then
			clr = Color(v.x, v.y, v.z)
		end
		if v2 and (v2.x ~= 0 or v2.y ~= 0 or v2.z ~= 0) then
			clr2 = Color(v2.x, v2.y, v2.z)
		end

		local txt = ply:GetNWString("wte_sbtstr") or ""

		local usergroup
		if ply.GetUserGroup then
			usergroup = ply:GetUserGroup()
		elseif ply:IsAdmin() then
			usergroup = "admin"
		elseif ply:IsSuperAdmin() then
			usergroup = "superadmin"
		end

		if wyozite.MakeRanksDefaultTags and txt == "" and (not wyozite.DontShowUserRank or usergroup ~= "user" ) then
			txt = usergroup
			if wyozite.RankColors then
				local rc = wyozite.RankColors[txt]
				if rc then
					if rc.r then -- a color
						clr = rc
						clr2 = nil
					else -- A table of two glow colors
						clr = rc[1]
						clr2 = rc[2]
					end
				end
			end
			txt = wyozite.RankReplacements[txt] or (txt:gsub("^%l", string.upper))
		end

		if clr and clr2 then
			local v3
			if clr.r == 255 and clr.g == 255 and clr.b == 255 and clr2.r == 255 and clr2.g == 255 and clr2.b == 255 then
				v3 = Vector(255*math.abs(math.sin(CurTime())), 255*math.abs(math.sin(CurTime()+1.8)), 255*math.abs(math.sin(CurTime()+2.6)))
			else
				local fv1, fv2 = Vector(clr.r, clr.g, clr.b), Vector(clr2.r, clr2.g, clr2.b)
				v3 = LerpVector((math.sin( CurTime()*2 )+1)/2, fv1, fv2)
			end
			clr = Color(v3.x, v3.y, v3.z)
		end

		label:SetColor(clr)

		return txt
	end, wyozite.TagColumnWidth)
end)

local function HasWTEPermission(permtag, ply)
	return hook.Call("WTEHasPermission", gmod.GetGamemode(), LocalPlayer(), permtag, ply)
end

-- Some quick helper functions for creating config GUI frames
local function CreateFrame(title, width, height)
	local frame = vgui.Create( "DFrame" ) 
	frame:SetSize( width, height )
	frame:Center()
	frame:MakePopup()
	frame:SetTitle(title)

	return frame
end

local function CreateMixer(parent)
	local mixer = vgui.Create("DColorMixer", parent)		
	mixer:SetPalette( true ) 
	mixer:SetAlphaBar( false )
	mixer:SetWangs( true )

	return mixer
end

hook.Add("TTTScoreboardMenu", "WyoziTEAddMenuOptions", function(menu)
	if wyozite.DontUseContextMenu then return end
	
	local ply = menu.Player
	if HasWTEPermission("setsbcolor", ply) then
		menu:AddOption("Modify name color", function()

			local frame = CreateFrame("Select name color", 267, 160)

			local Mixer = CreateMixer(frame)
			Mixer:Dock( FILL )

			local v = ply:GetNWVector("wte_sbclr")
			Mixer:SetColor( (v and (v.x ~= 0 or v.y ~= 0 or v.z ~= 0)) and Color(v.x,v.y,v.z) or Color(255, 255, 255) )

			frame.OnClose = function()
				if not IsValid(ply) then return end
				local clr = Mixer:GetColor()
				hook.Call("WTESetNameColor", gmod.GetGamemode(), ply, clr)
			end
		end):SetIcon("icon16/color_wheel.png")
	end
	if HasWTEPermission("setsbtagcolor", ply) then
		menu:AddOption("Modify tag color", function()
			local frame = CreateFrame("Select tag color", 270, 377)

			local Mixer = CreateMixer(frame)
			Mixer:SetPos(0, 22)
			Mixer:SetSize( 267, 166)

			local lbl = vgui.Create("DLabel", frame)
			lbl:SetText("Glow color (set to solid black to disable):")
			lbl:SetPos(10, 187)
			lbl:SetSize(200, 20)

			local Mixer2 = CreateMixer(frame)
			Mixer2:SetPos(0, 207)
			Mixer2:SetSize( 267, 166)

			local v = ply:GetNWVector("wte_sbtclr")
			Mixer:SetColor( (v and (v.x ~= 0 or v.y ~= 0 or v.z ~= 0)) and Color(v.x,v.y,v.z) or Color(255, 255, 255) )
			local v = ply:GetNWVector("wte_sbtclr2")
			Mixer2:SetColor( (v and (v.x ~= 0 or v.y ~= 0 or v.z ~= 0)) and Color(v.x,v.y,v.z) or Color(0, 0, 0) )

			frame.OnClose = function()
				if not IsValid(ply) then return end
				local clr, clr2 = Mixer:GetColor(), Mixer2:GetColor()
				hook.Call("WTESetTagColor", gmod.GetGamemode(), ply, clr, clr2)
			end
		end):SetIcon("icon16/tag_blue.png")
	end
	if HasWTEPermission("setsbtagtext", ply) then
		menu:AddOption("Modify tag text", function()
			local frame = CreateFrame("Set tag text", 267, 60)

			local TagText = vgui.Create( "DTextEntry", frame )
			TagText:Dock( FILL )
			TagText:SetText(ply:GetNWString("wte_sbtstr") or "")

			TagText:RequestFocus()

			local function WeBeDone()
				if not IsValid(ply) then return end
				hook.Call("WTESetTagText", gmod.GetGamemode(), ply, TagText:GetText())
			end

			frame.OnClose = WeBeDone
			TagText.OnEnter = function() frame:Close() end
		end):SetIcon("icon16/tag_blue_edit.png")
	end
end)
concommand.Add("wyozite_reloadscoreboard", function()
	GAMEMODE:ScoreboardCreate()
	wyozite.OverrideVGUI()
end)
