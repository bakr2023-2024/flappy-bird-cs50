PlayState = Class({ __includes = BaseState })
function PlayState:init()
	self.bird = Bird()
	self.pipePairs = {}
	self.spawnTimer = 0
	self.prevY = -PIPE_HEIGHT + math.random(80) + 20
end
function PlayState:update(dt)
	self.spawnTimer = self.spawnTimer + dt
	if self.spawnTimer > 2 then
		local y =
			math.max(math.min(self.prevY + math.random(-20, 20), VH - GAP_HEIGHT - PIPE_HEIGHT), -PIPE_HEIGHT + 10)
		self.prevY = y
		table.insert(self.pipePairs, PipePair(y))
		self.spawnTimer = 0
	end
	self.bird:update(dt)
	for i = #self.pipePairs, 1, -1 do
		self.pipePairs[i]:update(dt)
		if self.bird:collides(self.pipePairs[i].upper) or self.bird:collides(self.pipePairs[i].lower) then
			gsm:change("title")
		end
		if self.pipePairs[i].remove then
			table.remove(self.pipePairs, i)
		end
	end
end
function PlayState:render()
	self.bird:render()
	for i, pair in ipairs(self.pipePairs) do
		pair:render()
	end
end
function PlayState:enter() end
function PlayState:exit() end
