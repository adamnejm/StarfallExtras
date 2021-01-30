
local checkluatype = SF.CheckLuaType

local tonumber = tonumber
local string_sub = string.sub
local hex_to_rgb = {
	[3] = function(v) return {
			tonumber("0x"..v[1])*17,
			tonumber("0x"..v[2])*17,
			tonumber("0x"..v[3])*17,
			255
		} end,
	[4] = function(v) return {
			tonumber("0x"..v[1])*17,
			tonumber("0x"..v[2])*17,
			tonumber("0x"..v[3])*17,
			tonumber("0x"..v[4])*17
		} end,
	[6] = function(v) return {
			tonumber("0x"..string_sub(v,1,2)),
			tonumber("0x"..string_sub(v,3,4)),
			tonumber("0x"..string_sub(v,5,6)),
			255
		} end,
	[8] = function(v) return {
			tonumber("0x"..string_sub(v,1,2)),
			tonumber("0x"..string_sub(v,3,4)),
			tonumber("0x"..string_sub(v,5,6)),
			tonumber("0x"..string_sub(v,7,8))
		} end,
}

return function(instance)

local color_methods, color_meta, cwrap, unwrap = instance.Types.Color.Methods, instance.Types.Color, instance.Types.Color.Wrap, instance.Types.Color.Unwrap
local function wrap(tbl)
	return setmetatable(tbl, color_meta)
end

-- -------------------------------------------

--- Creates a table struct that resembles a Color
-- @name builtins_library.Color
-- @class function
-- @param r - Red or string hexadecimal color
-- @param g - Green
-- @param b - Blue
-- @param a - Alpha
-- @return New color
local ORIGINAL_COLOR_CONSTRUCTOR = instance.env.Color
function instance.env.Color(r, ...)
	if type(r) == "string" then
		if r[1] == "#" then r = string.sub(r, 2) end
		
		if string.match(r, "%X") then
			SF.Throw("Invalid characters in hexadecimal color", 2)
		else
			local h2r = hex_to_rgb[#r]
			if h2r then
				return wrap(h2r(r))
			else
				SF.Throw("Invalid hexadecimal color length", 2)
			end
		end
	else
		return ORIGINAL_COLOR_CONSTRUCTOR(r, ...)
	end
end

--- Creates a randomized Color
-- @name builtins_library.ColorRand
-- @param min Number lower limit for each component. Default = 0
-- @param max Number upper limit for each component. Default = 255
-- @param alpha Boolean, whether to randomize the alpha value. Default = False
function instance.env.ColorRand(min, max, alpha)
	if min ~= nil then checkluatype(min, TYPE_NUMBER) else min = 0 end
	if max ~= nil then checkluatype(max, TYPE_NUMBER) else max = 255 end
	if alpha ~= nil then checkluatype(alpha, TYPE_BOOL) end
	
	local random = math.random
	return wrap { random(min, max), random(min, max), random(min, max), alpha and math.random(min, max) or 255 }
end

--- Returns a hexadecimal representation of the color
-- @return String hexadecimal color
function color_methods:getHex()
	local tohex = bit.tohex
	if self[4] == 255 then
		return tohex(self[1], 2)..tohex(self[2], 2)..tohex(self[3], 2)
	else
		return tohex(self[1], 2)..tohex(self[2], 2)..tohex(self[3], 2)..tohex(self[4], 2)
	end
end


end
