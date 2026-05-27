WW = 1280
WH = 720
VW = 512
VH = 288
HVW = VW / 2
HVH = VH / 2
push = require("push")

function love.load()
	love.window.setTitle("Fifty Bird")
	love.graphics.setDefaultFilter("nearest", "nearest")
	background = love.graphics.newImage("background.png")
	ground = love.graphics.newImage("ground.png")
	love.window.setMode(WW, WH, { resizable = false, vsync = true, fullscreen = false })
	push:setupScreen(VW, VH, WW, WH)
end
function love.draw()
	push:start()
	love.graphics.draw(background, 0, 0)
	love.graphics.draw(ground, 0, VH - 16)
	push:finish()
end
