
local checkluatype = SF.CheckLuaType

return function(instance)

local color_methods, color_meta, cwrap, unwrap = instance.Types.Color.Methods, instance.Types.Color, instance.Types.Color.Wrap, instance.Types.Color.Unwrap
local function wrap(tbl)
	return setmetatable(tbl, color_meta)
end

-- -------------------------------------------

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

end
