Countdown = Class({ __includes = BaseState })

local COUNTDOWN_TIMER = 0.75
function Countdown:init()
	self.timer = 0
	self.count = 3
end
function Countdown:update(dt)
	self.timer = self.timer + dt
	if self.timer > COUNTDOWN_TIMER then
		self.timer = self.timer % COUNTDOWN_TIMER
		self.count = self.count - 1
		if self.count == 0 then
			gsm:change("play")
		end
	end
end
function Countdown:render()
	love.graphics.setFont(hugeFont)
	love.graphics.printf(tostring(self.count), 0, 120, VW, "center")
end
