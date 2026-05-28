Bird = Class({})
local GRAVITY = 980
function Bird:init()
	self.image = love.graphics.newImage("textures/bird.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = HVW - self.width / 2
	self.y = HVH - self.height / 2
	self.dy = 0
end
function Bird:update(dt)
	self.dy = self.dy + GRAVITY * dt
	if love.keyboard.wasPressed("space") or love.mouse.wasPressed(1) then
		self.dy = -250
		sounds["jump"]:play()
	end
	self.y = self.y + self.dy * dt
end
function Bird:collides(pipe)
	return not (
		(self.x + 2) + (self.width - 4) <= pipe.x
		or (self.y + 2) + (self.height - 4) <= pipe.y
		or pipe.x + PIPE_WIDTH <= (self.x + 2)
		or pipe.y + PIPE_HEIGHT <= (self.y + 2)
	)
end
function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end
