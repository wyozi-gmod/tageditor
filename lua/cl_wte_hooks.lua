hook.Add("TTTScoreboardColorForPlayer", "WyoziTESbColor", function(ply)
	local v = ply:GetNWVector("wte_sbclr")
	if v and (v.x ~= 0 or v.y ~= 0 or v.z ~= 0) then
		return Color(v.x, v.y, v.z)
	end
end, -5)