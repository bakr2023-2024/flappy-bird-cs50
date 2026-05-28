ScoreState = Class({ __includes = BaseState })
function ScoreState:init()
	self.score = 0
	self.medal = "empty"
end
function ScoreState:enter(params)
	self.score = params.score
    -- set medal based on player score
	self.medal = self.score < 5 and "empty" or self.score < 10 and "bronze" or self.score < 15 and "silver" or "gold"
end
function ScoreState:update()
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		gsm:change("countdown")
	end
end
function ScoreState:render()
	love.graphics.setFont(flappyFont)
	love.graphics.printf("Fifty Bird", 0, 32, VW, "center")

	love.graphics.setFont(mediumFont)
	love.graphics.printf("Your Score: " .. tostring(self.score), 0, 64, VW, "center")
	love.graphics.printf("Press Enter to restart", 0, 100, VW, "center")
    -- show medal
	love.graphics.draw(textures[self.medal], HVW - 32, HVH - 32)

end
