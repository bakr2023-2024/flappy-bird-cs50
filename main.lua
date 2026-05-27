WW = 1280
WH = 720
VW = 512
VH = 288
HVW = VW / 2
HVH = VH / 2
local backgroundScroll = 0
local groundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413
push = require("push")
function love.load()
	love.window.setTitle("Fifty Bird")
	love.graphics.setDefaultFilter("nearest", "nearest")
	background = love.graphics.newImage("background.png")
	ground = love.graphics.newImage("ground.png")
	love.window.setMode(WW, WH, { resizable = false, vsync = true, fullscreen = false })
	push:setupScreen(VW, VH, WW, WH)
end
function love.update(dt)
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VW
end
function love.draw()
	push:start()
	love.graphics.draw(background, -backgroundScroll, 0)
	love.graphics.draw(ground, -groundScroll, VH - 16)
	push:finish()
end
