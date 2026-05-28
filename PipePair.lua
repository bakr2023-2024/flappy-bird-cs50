GAP_HEIGHT = 110
PipePair = Class({})

function PipePair:init(y)
	self.x = VW + 32
	self.y = y
	self.upper = Pipe(true, y)
	self.lower = Pipe(false, y + GAP_HEIGHT + PIPE_HEIGHT)
	self.remove = false
end

function PipePair:update(dt)
	if self.x > -PIPE_WIDTH then
		self.x = self.x - PIPE_SPEED * dt
		self.upper.x = self.x
		self.lower.x = self.x
	else
		self.remove = true
	end
end

function PipePair:render()
	self.upper:render()
	self.lower:render()
end
