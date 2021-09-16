local td = {}
td.__index = td

function td.new(tab)
	local self = setmetatable({}, td)
	self.writer = require('writer').new()
	self.ot = tab
	self.memory = {}
	self.visitedTables = {}
	return self
end

function td:cacheGlobalMemory()
	local currentTrack = {'_G'}
	local function internalCount(t) local c = 0 for _,__ in pairs(t) do c = c + 1 end return c end
	
	local function createNamespace()
		local namespace = ''
		for key, value in pairs(currentTrack) do
			if value ~= '_G' and value ~= 'package' then 
				namespace = namespace .. value .. '.'
			end
		end
		return namespace
	end

	local function internalCache(t)
		local len = internalCount(t)
		local curr = 0
		for key, value in pairs(t) do
			curr = curr + 1
			if type(value) == 'function' or type(value) == 'table' then
				if type(value) == 'table' and self.visitedTables[value] == nil then
					self.visitedTables[value] = key
					currentTrack[#currentTrack+1] = key
					internalCache(value)
				end
				self.memory[value] = createNamespace() .. key
			end
			if curr == len then
				table.remove(currentTrack, #currentTrack)
			end
		end
	end

	internalCache(_G)
end

function td:resolve()
	self:cacheGlobalMemory()
	
	local internalResolve
	local function internalResolveSpecial(value)
		if value == _G then return '_G' end
		if self.memory[value] then return self.memory[value] end
		if type(value) == 'table' then 
			if self.visitedTables[value] ~= nil then 
				if self.visitedTables[value] == true then return "{...}" end
				return self.visitedTables
			end
			internalResolve(value)
			return ''
		end
		return tostring(value)
	end

	local function internalResolveValue(value) 
		if type(value) == 'function' or type(value) == 'table' then 
			return internalResolveSpecial(value) 
		elseif type(value) == 'string' then
			return '[[' .. tostring(value) .. ']]'
		elseif type(value) == 'number' and value == math.huge then
			return "math.huge"
		elseif type(value) == 'number' and value == math.pi then
			return "math.pi"
		else
			return tostring(value)
		end 
	end

	local function internalCount(t) local c = 0 for _,__ in pairs(t) do c = c + 1 end return c end

	internalResolve = function(t, key)
		local len = internalCount(t)
		local curr = 0
		if len ~= 0 then self.writer:writeLine("{") else self.writer:write("{") end
		self.writer:incIndent()
		self.visitedTables[t] = true
		if key then
			self.visitedTables[t] = key
		end
		for key, value in pairs(t) do
			curr = curr + 1
			if type(key) == 'string' then
				if string.find(key, ' ') then
					self.writer:writeIndent('["' .. key .. '"] = ')
				else
					self.writer:writeIndent(key .. ' = ')
				end
				self.writer:write(internalResolveValue(value))
			elseif type(key) == 'number' then
				self.writer:writeIndent('[' .. tostring(key) .. '] = ')
				self.writer:write(internalResolveValue(value))
			elseif type(key) == 'table' then
				self.writer:writeIndent('[')
				internalResolve(key)
				self.writer:write('] = ')
				self.writer:write(internalResolveValue(value))
			elseif type(key) == 'function' then
				self.writer:writeIndent('[' .. internalResolveValue(key) .. '] = ')
				self.writer:write(internalResolveValue(value))
			else
				self.writer:writeIndent('[' .. internalResolveValue(key) .. '] = ')
				self.writer:write(internalResolveValue(value))
			end
			if curr == len then self.writer:writeLine('') else self.writer:writeLine(',') end
		end
		self.writer:unindent()
		if len ~= 0 then self.writer:writeIndent("}") else self.writer:write("}") end
	end
	internalResolve(self.ot)
end

function td:toString()
	self:resolve()
	return self.writer:toString()
end

return td
