function wyozite.SetSBColor(ply, r, g, b)
	ply:SetNWVector("wte_sbclr", Vector(r, g, b))
	ply:SetPData("wte_sbclr", tostring(r) .. "," .. tostring(g) .. "," .. tostring(b))
end

function wyozite.GetSBColor(ply)
	local pdata = ply:GetPData("wte_sbclr")
	if pdata then
		local spl = pdata:Split(",")
		return tonumber(spl[1]), tonumber(spl[2]), tonumber(spl[3])
	end
end

function wyozite.SetSBTagColor(ply, r, g, b)
	ply:SetNWVector("wte_sbtclr", Vector(r, g, b))
	ply:SetPData("wte_sbtclr", tostring(r) .. "," .. tostring(g) .. "," .. tostring(b))
end

function wyozite.GetSBTagColor(ply)
	local pdata = ply:GetPData("wte_sbtclr")
	if pdata then
		local spl = pdata:Split(",")
		return tonumber(spl[1]), tonumber(spl[2]), tonumber(spl[3])
	end
end

function wyozite.SetSBTagColor2(ply, r, g, b)
	ply:SetNWVector("wte_sbtclr2", Vector(r, g, b))
	ply:SetPData("wte_sbtclr2", tostring(r) .. "," .. tostring(g) .. "," .. tostring(b))
end

function wyozite.GetSBTagColor2(ply)
	local pdata = ply:GetPData("wte_sbtclr2")
	if pdata then
		local spl = pdata:Split(",")
		return tonumber(spl[1]), tonumber(spl[2]), tonumber(spl[3])
	end
end

function wyozite.SetSBTagText(ply, str)
	ply:SetNWString("wte_sbtstr", str)
	ply:SetPData("wte_sbtstr", str)
end

function wyozite.GetSBTagText(ply)
	return ply:GetPData("wte_sbtstr")
end

hook.Add("PlayerInitialSpawn", "WyoziTESetPersistentColors", function(ply)
	local r, g, b = wyozite.GetSBColor(ply)
	if r then
		ply:SetNWVector("wte_sbclr", Vector(r, g, b))
	end
	local r, g, b = wyozite.GetSBTagColor(ply)
	if r then
		ply:SetNWVector("wte_sbtclr", Vector(r, g, b))
	end
	local r, g, b = wyozite.GetSBTagColor2(ply)
	if r then
		ply:SetNWVector("wte_sbtclr2", Vector(r, g, b))
	end
	ply:SetNWString("wte_sbtstr", wyozite.GetSBTagText(ply) or "")
end)