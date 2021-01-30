
local checkluatype = SF.CheckLuaType

return function(instance)
	
	local ang_methods, ang_meta, awrap, unwrap = instance.Types.Angle.Methods, instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
	local function wrap(tbl)
		return setmetatable(tbl, ang_meta)
	end
	
	-- -------------------------------------------
	
	--- Randomizes the angle
	-- Self-modifies
	-- @param min Number lower limit of each component. Default = -180
	-- @param max Number upper limit of each component. Default = 180
	function ang_methods:randomize(min, max, integers)
		if min then checkluatype(min, TYPE_NUMBER) else min = -180 end
		if max then checkluatype(max, TYPE_NUMBER) else max = 180 end
		
		local rand = math.Rand
		return wrap { rand(min, max), rand(min, max), rand(min, max) }
	end
	
	--- Normalizes the angle so that each component is constrained within -180..180 range
	-- Self-modifies
	-- @return nil
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
