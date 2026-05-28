Pipe = Class({})
PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70
function Pipe:init(isUpper, y)
	self.x = VW
	self.y = y
	self.scaleY = isUpper and -1 or 1
end

function Pipe:render()
	love.graphics.draw(
	textures["pipe"],
		self.x,
		self.scaleY == -1 and self.y + PIPE_HEIGHT or self.y,
		0,
		1,
		self.scaleY
	)
end
