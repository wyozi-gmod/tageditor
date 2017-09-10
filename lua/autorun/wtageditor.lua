
local wyozite_debug = SERVER and CreateConVar("wyozite_debug", "0", FCVAR_ARCHIVE) or CreateClientConVar("wyozite_debug", "0", FCVAR_ARCHIVE)

wyozite = wyozite or {}
function wyozite.Debug(...)
	if not wyozite_debug:GetBool() or not game.IsDedicated() then return end
	print("[WULXSYNC-DEBUG] ", ...)
end

local function AddClient(fil)
	if SERVER then AddCSLuaFile(fil) end
	if CLIENT then include(fil) end
end

local function AddServer(fil)
	if SERVER then include(fil) end
end

local function AddShared(fil)
	include(fil)
	AddCSLuaFile(fil)
end

AddShared("sh_wte_config.lua")

AddClient("cl_wte_vguioverrides.lua")
AddClient("cl_wte_hooks.lua")
AddServer("sv_wte_api.lua")
if ulx then
	AddShared("sh_wte_ulxcmds.lua")
else
	AddShared("sh_wte_vanillacmds.lua")
end