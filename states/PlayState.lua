PlayState = Class({ __includes = BaseState })
function PlayState:init()
	self.bird = Bird()
	self.pipePairs = {}
	self.spawnTimer = 0
	self.prevY = -PIPE_HEIGHT + math.random(80) + 20
	self.score = 0
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
	if self.bird.y > VH - 15 then
		gsm:change("score", { score = self.score })
	end
	for i = #self.pipePairs, 1, -1 do
		if not self.pipePairs[i].scored and self.bird.x > self.pipePairs[i].upper.x + PIPE_WIDTH then
			self.score = self.score + 1
			self.pipePairs[i].scored = true
		end
		self.pipePairs[i]:update(dt)
		if self.bird:collides(self.pipePairs[i].upper) or self.bird:collides(self.pipePairs[i].lower) then
			gsm:change("score", { score = self.score })
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
