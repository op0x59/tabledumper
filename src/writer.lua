local writer = {}
writer.__index = writer

function writer.new()
	local self = setmetatable({}, writer)
	self.indent = 0
	self.text = ''
	return self
end

function writer:writeIndentation()
	for i = 1, self.indent do
		self.text = self.text .. "\t"
	end
end

function writer:write(text)
	self.text = self.text .. text
end

function writer:writeLine(text)
	self.text = self.text .. text .. "\n"
end

function writer:writeIndent(text)
	self:writeIndentation()
	self:write(text)
end

function writer:writeLineIndent(text)
	self:writeIndentation()
	self:writeLine(text)
end

function writer:incIndent()
	self.indent = self.indent + 1
end

function writer:unindent()
	self.indent = self.indent - 1
end

function writer:toString() return self.text end
function writer:clear() self.text = '' self.indent = 0 end

return writer
