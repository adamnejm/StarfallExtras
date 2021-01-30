
local checkluatype = SF.CheckLuaType

return function(instance)

local vec_methods, vec_meta, vwrap, unwrap = instance.Types.Vector.Methods, instance.Types.Vector, instance.Types.Vector.Wrap, instance.Types.Vector.Unwrap
local function wrap(tbl)
	return setmetatable(tbl, vec_meta)
end

-- -------------------------------------------

--- Creates a randomized Vector
-- @name builtins_library.VectorRand
-- @class function
-- @param min Number lower limit for each component. Default = -1
-- @param max Number upper limit for each component. Default = 1
-- @return Randomized vector
function instance.env.VectorRand(min, max)
	if min ~= nil then checkluatype(min, TYPE_NUMBER) else min = -1 end
	if max ~= nil then checkluatype(max, TYPE_NUMBER) else max = 1 end
	
	local rand = math.Rand
	return wrap { rand(min, max), rand(min, max), rand(min, max) }
end

--- Randomizes the vector components
-- Self-modifies
-- @param min Number lower limit for each component. Default = -1
-- @param max Number upper limit for each component. Default = 1
function vec_methods:randomize(min, max)
	if min ~= nil then checkluatype(min, TYPE_NUMBER) else min = -1 end
	if max ~= nil then checkluatype(max, TYPE_NUMBER) else max = 1 end
	
	local rand = math.Rand
	self[1] = rand(min, max)
	self[2] = rand(min, max)
	self[3] = rand(min, max)
end



end
