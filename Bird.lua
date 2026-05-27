Bird = Class({})
function Bird:init()
	self.image = love.graphics.newImage("bird.png")
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = HVW - self.width / 2
	self.y = HVH - self.height / 2
end
function Bird:update(dt) end
function Bird:render()
	love.graphics.draw(self.image, self.x, self.y)
end
