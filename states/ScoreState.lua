ScoreState = Class({ __includes = BaseState })

function ScoreState:init()
	self.score = 0
end
function ScoreState:enter(params)
	self.score = params.score
end
function ScoreState:update()
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		gsm:change("play")
	end
end
function ScoreState:render()
	love.graphics.setFont(flappyFont)
	love.graphics.printf("Fifty Bird", 0, 64, VW, "center")

	love.graphics.setFont(mediumFont)
	love.graphics.printf("Your Score: " .. tostring(self.score), 0, 100, VW, "center")
	love.graphics.printf("Press Enter to restart", 0, 118, VW, "center")
end
