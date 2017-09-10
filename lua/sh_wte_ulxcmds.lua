wyozite.Debug("Adding ULX TagEditor commands")

function ulx.setsbcolor( calling_ply, target_plys, r, g, b )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		wyozite.SetSBColor(v, r, g, b)
		
		table.insert( affected_plys, v )
	end

	--ulx.fancyLogAdmin( calling_ply, "#A setsbcolorped #T with #i #i #i", affected_plys, r, g, b )
end

local setsbcolor = ulx.command( "Tag Editor", "ulx setsbcolor", ulx.setsbcolor, "!setsbcolor" )
setsbcolor:addParam{ type=ULib.cmds.PlayersArg }
setsbcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="red", ULib.cmds.round }
setsbcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="green", ULib.cmds.round }
setsbcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="blue", ULib.cmds.round }
setsbcolor:defaultAccess( ULib.ACCESS_ADMIN )
setsbcolor:help( "setsbcolors target(s) with given damage." )

function ulx.setsbtagcolor( calling_ply, target_plys, r, g, b, r2, g2, b2 )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		wyozite.SetSBTagColor(v, r, g, b)
		wyozite.SetSBTagColor2(v, r2, g2, b2)
		
		table.insert( affected_plys, v )
	end

	--ulx.fancyLogAdmin( calling_ply, "#A setsbtagcolorped #T with #i #i #i", affected_plys, r, g, b )
end

local setsbtagcolor = ulx.command( "Tag Editor", "ulx setsbtagcolor", ulx.setsbtagcolor, "!setsbtagcolor" )
setsbtagcolor:addParam{ type=ULib.cmds.PlayersArg }
setsbtagcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="red", ULib.cmds.round }
setsbtagcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="green", ULib.cmds.round }
setsbtagcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="blue", ULib.cmds.round }
setsbtagcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="red2", ULib.cmds.round }
setsbtagcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="green2", ULib.cmds.round }
setsbtagcolor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="blue2", ULib.cmds.round }
setsbtagcolor:defaultAccess( ULib.ACCESS_ADMIN )
setsbtagcolor:help( "setsbtagcolors target(s) with given damage." )


function ulx.setsbtagtext( calling_ply, target_plys, str )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		wyozite.SetSBTagText(v, str)
		
		table.insert( affected_plys, v )
	end

	--ulx.fancyLogAdmin( calling_ply, "#A setsbtagtextped #T with #s", affected_plys, str)
end

local setsbtagtext = ulx.command( "Tag Editor", "ulx setsbtagtext", ulx.setsbtagtext, "!setsbtagtext" )
setsbtagtext:addParam{ type=ULib.cmds.PlayersArg }
setsbtagtext:addParam{ type=ULib.cmds.StringArg, hint="text", ULib.cmds.takeRestOfLine }
setsbtagtext:defaultAccess( ULib.ACCESS_ADMIN )
setsbtagtext:help( "setsbtagtexts target(s) with given damage." )

if CLIENT then
	hook.Add("WTESetNameColor", "WTEULX", function(ply, clr)
		RunConsoleCommand("ulx", "setsbcolor", "$" .. tostring(ply:UniqueID()), tostring(clr.r), tostring(clr.g), tostring(clr.b))
	end)
	hook.Add("WTESetTagColor", "WTEULX", function(ply, clr, clr2)
		RunConsoleCommand("ulx", "setsbtagcolor", "$" .. tostring(ply:UniqueID()), tostring(clr.r), tostring(clr.g), tostring(clr.b), tostring(clr2.r or 0), tostring(clr2.g or 0), tostring(clr2.b or 0))
	end)
	hook.Add("WTESetTagText", "WTEULX", function(ply, text)
		RunConsoleCommand("ulx", "setsbtagtext", "$" .. tostring(ply:UniqueID()), text)
	end)
	hook.Add("WTEHasPermission", "WTEULX", function(ply, perm)
		return ply:query("ulx " .. perm)
	end)
end