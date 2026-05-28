TitleState = Class({ __includes = BaseState })
function TitleState:update()
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		gsm:change("countdown")
	end
end
function TitleState:render()
	love.graphics.setFont(flappyFont)
	love.graphics.printf("Fifty Bird", 0, 64, VW, "center")

	love.graphics.setFont(mediumFont)
	love.graphics.printf("Press Enter", 0, 100, VW, "center")
end
