wyozite.Debug("Adding Vanilla TagEditor commands")

if SERVER then
	util.AddNetworkString("wyozite_set")

	net.Receive("wyozite_set", function(le, cl)
		local toset = net.ReadString()
		local toply = net.ReadEntity()
		if not IsValid(toply) or not toply:IsPlayer() then return end

		if not hook.Call("WTEHasPermission", gmod.GetGamemode(), cl, toset, toply) then
			return
		end

		if toset == "setsbcolor" then
			local clr = net.ReadTable()
			wyozite.SetSBColor(toply, clr.r, clr.g, clr.b)
		elseif toset == "setsbtagcolor" then
			local clr = net.ReadTable()
			wyozite.SetSBTagColor(toply, clr.r, clr.g, clr.b)
			local clr2 = net.ReadTable()
			wyozite.SetSBTagColor2(toply, clr2.r or 0, clr2.g or 0, clr2.b or 0)
		elseif toset == "setsbtagtext" then
			local str = net.ReadString()
			wyozite.SetSBTagText(toply, str)
		end

	end)
end

if CLIENT then
	hook.Add("WTESetNameColor", "WTEVanilla", function(ply, clr)
		net.Start("wyozite_set")
			net.WriteString("setsbcolor")
			net.WriteEntity(ply)
			net.WriteTable(clr)
		net.SendToServer()
	end)
	hook.Add("WTESetTagColor", "WTEVanilla", function(ply, clr, clr2)
		net.Start("wyozite_set")
			net.WriteString("setsbtagcolor")
			net.WriteEntity(ply)
			net.WriteTable(clr)
			net.WriteTable(clr2 or {})
		net.SendToServer()
	end)
	hook.Add("WTESetTagText", "WTEVanilla", function(ply, text)
		net.Start("wyozite_set")
			net.WriteString("setsbtagtext")
			net.WriteEntity(ply)
			net.WriteString(text)
		net.SendToServer()
	end)
end
hook.Add("WTEHasPermission", "WTEVanilla", function(ply, perm)
	return ply:IsAdmin()
end)