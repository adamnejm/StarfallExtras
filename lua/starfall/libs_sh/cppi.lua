
local checkluatype = SF.CheckLuaType
local haspermission = SF.Permissions.hasAccess
local registerprivilege = SF.Permissions.registerPrivilege
local dgetmeta = debug.getmetatable

registerprivilege("cppi.getFriends", "Get friends", "Allows the user to get your prop protection friends", { client = { default = 2 } })

local plymeta = FindMetaTable("Player")
local entmeta = FindMetaTable("Entity")

--- Common Prop Protection Interface library 
-- Functions in this library only work when prop protection that follows the CPPI is available
-- Use cppi.isAvailable to check if all other functions can be accessed
-- Some functions might still not be available depending on the prop protection, in that case they'll return nil
-- @name cppi
-- @class library
-- @libtbl cppi_library
SF.RegisterLibrary("cppi")

return function(instance)

local CPPI = CPPI

local cppi_library = instance.Libraries.cppi

--- Checks whether the prop protection that implements CPPI is available
-- @return Boolean, True if available
function cppi_library.isAvailable()
	return CPPI and true or false
end

-- Don't do anything else if CPPI is not installed
if not CPPI then return end

local checkpermission = instance.player ~= SF.Superuser and SF.Permissions.check or function() end

--local owrap, ounwrap = instance.WrapObject, instance.UnwrapObject
local ply_wrap = instance.Types.Player.Wrap

local getent, getply
instance:AddHook("initialize", function()
	getent = instance.Types.Entity.GetEntity
	getply = instance.Types.Player.GetPlayer
end)

-- People are dumb, so do this
local CPPI_DEFER = CPPI.CPPI_DEFER or CPPI.DEFER or CPPI_DEFER
local CPPI_NOTIMPLEMENTED = CPPI.CPPI_NOTIMPLEMENTED or CPPI.NOTIMPLEMENTED or CPPI_NOTIMPLEMENTED

-- -------------------------------------------

--- Returns name of the prop protection
-- Implementation: Required
-- @return String name
function cppi_library.getName()
	return CPPI.GetName and CPPI.GetName()
end

--- Returns version of the prop protection
-- Implementation: Required
-- @return String version
function cppi_library.getVersion()
	return CPPI.GetVersion and CPPI.GetVersion()
end

--- Returns interface version the prop protection is based on
-- Implementation: Required
-- @return String interface version
function cppi_library.getInterfaceVersion()
	return CPPI.GetInterfaceVersion and CPPI.GetInterfaceVersion()
end

--- Returns prop protection friends of a player
-- Implementation: Recommended
-- @param ply Player to get the friends of. If CLIENT, will be forced to player()
-- @return Table containing players' friends or nil if not implemented
function cppi_library.getFriends(ply)
	if not plymeta.CPPIGetFriends then return end
	if CLIENT then
		checkpermission(instance, nil, "cppi.getFriends")
		ply = LocalPlayer()
		
		local friends = ply:CPPIGetFriends()
		if friends ~= CPPI_NOTIMPLEMENTED and friends ~= CPPI_DEFER then
			local ret = {}
			for k, v in pairs(friends) do
				ret[k] = plywrap(v)
			end
			return ret
		end
	else
		-- ply = getply(ply)
		-- Meh no easy way of doing this
		-- Will have to add shared permissions, then finish this
	end
end


end
