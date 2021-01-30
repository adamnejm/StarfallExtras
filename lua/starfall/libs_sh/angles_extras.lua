
local checkluatype = SF.CheckLuaType

return function(instance)

local ang_methods, ang_meta, awrap, unwrap = instance.Types.Angle.Methods, instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
local function wrap(tbl)
	return setmetatable(tbl, ang_meta)
end

-- -------------------------------------------

--- Creates a randomized Angle
-- @name builtins_library.AngleRand
-- @class function
-- @param min Number lower limit for each component. Default = -90 for pitch, -180 for yaw and roll
-- @param max Number upper limit for each component. Default = 90 for pitch, 180 for yaw and roll
-- @return Randomized vector
function instance.env.AngleRand(min, max)
	if min ~= nil then checkluatype(min, TYPE_NUMBER) end
	if max ~= nil then checkluatype(max, TYPE_NUMBER) end
	
	local rand = math.Rand
	return wrap { rand(min or -90, max or 90), rand(min or -180, max or 180), rand(min or -180, max or 180) }
end

--- Randomizes the angle components
-- Self-modifies
-- @param min Number lower limit for each component. Default = -90 for pitch, -180 for yaw and roll
-- @param max Number upper limit for each component. Default = 90 for pitch, 180 for yaw and roll
function ang_methods:randomize(min, max)
	if min ~= nil then checkluatype(min, TYPE_NUMBER) end
	if max ~= nil then checkluatype(max, TYPE_NUMBER) end
	
	local rand = math.Rand
	self[1] = rand(min or -90,  max or 90)
	self[2] = rand(min or -180, max or 180)
	self[3] = rand(min or -180, max or 180)
end


--- Normalizes the angle so that each component is constrained within -180..180 range
-- Self-modifies
function ang_methods:normalize()
	self[1] = (self[1] + 180) % 360 - 180
	self[2] = (self[2] + 180) % 360 - 180
	self[3] = (self[3] + 180) % 360 - 180
end

--- Returns new normalized angle where each component is constrained within -180..180 range
-- @return Normalized angle
function ang_methods:getNormalized()
	return wrap { (self[1] + 180) % 360 - 180, (self[2] + 180) % 360 - 180, (self[3] + 180) % 360 - 180 }
end

end
