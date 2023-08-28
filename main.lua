local ronux = {}

ronux.new = function()
	local self = {}

	self.states = {}
	self.normal_states = {}
	self.updater_states = {}

	self.add_state = function(name, state)
		self.normal_states[name] = state
		self.states[name] = state.value
	end

	self.add_updater_state = function(name, state)
		state.condition = state.condition or function()
			return true
		end
		state.update = state.update or function() end
		state.update_time = state.update_time or 0.1
		self.updater_states[name] = state
		self.states[name] = state.value
	end

	self.set_state = function(name, value)
		if self.normal_states[name] then
			self.normal_states[name].value = value
			self.states[name] = value
		elseif self.updater_states[name] then
			self.updater_states[name].value = value
			self.states[name] = value
		else
			error("State does not exist")
		end
	end

	self.get_state = function(name)
		if self.normal_states[name] then
			return self.normal_states[name].value
		elseif self.updater_states[name] then
			return self.updater_states[name].value
		else
			error("State does not exist")
		end
	end

	self.start_updaters = function()
		for _, state in pairs(self.updater_states) do
			spawn(function()
				while state.condition(self.states) do
					state.update(self.states)
					wait(state.update_time)
				end
			end)
		end
	end

	return self
end

return ronux
