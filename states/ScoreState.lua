ScoreState = Class({ __includes = BaseState })

function ScoreState:init()
	self.score = 0
end
function ScoreState:enter(params)
	self.score = params.score
end
function ScoreState:update(dt)
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		gsm:change("title")
	end
end
function ScoreState:render()
	love.graphics.printf(
		"Game Over\nYour Score: " .. tostring(self.score) .. "\nPress Enter to restart",
		0,
		10,
		VW,
		"center"
	)
end
