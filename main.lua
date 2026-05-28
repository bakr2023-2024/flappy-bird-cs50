WW = 1280
WH = 720
VW = 512
VH = 288
HVW = VW / 2
HVH = VH / 2
push = require("push")
Class = require("class")
require("Bird")
require("Pipe")
require("PipePair")
local backgroundScroll = 0
local groundScroll = 0
-- parallex effect as ground is closer than background so ground scrolls faster than background
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local pipePairs = {}
local spawnTimer = 0
local BACKGROUND_LOOPING_POINT = 413
local GROUND_LOOPING_POINT = 514
local prevY = -PIPE_HEIGHT + math.random(80) + 20
local scrolling = true
function love.load()
	love.window.setTitle("Fifty Bird")
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())
	background = love.graphics.newImage("background.png")
	ground = love.graphics.newImage("ground.png")
	bird = Bird()
	love.keyboard.keysPressed = {}
	love.window.setMode(WW, WH, { resizable = false, vsync = true, fullscreen = false })
	push:setupScreen(VW, VH, WW, WH)
end
function love.update(dt)
	if scrolling then
		backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
		groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT
		spawnTimer = spawnTimer + dt
		if spawnTimer > 2 then
			local y = math.max(math.min(prevY + math.random(-20, 20), VH - GAP_HEIGHT - PIPE_HEIGHT), -PIPE_HEIGHT + 10)
			prevY = y
			table.insert(pipePairs, PipePair(y))
			spawnTimer = 0
		end
		bird:update(dt)
		for i = #pipePairs, 1, -1 do
			pipePairs[i]:update(dt)
			if bird:collides(pipePairs[i].upper) or bird:collides(pipePairs[i].lower) then
				scrolling = false
			end
			if pipePairs[i].remove then
				table.remove(pipePairs, i)
			end
		end
	end
	love.keyboard.keysPressed = {}
end
function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	if key == "escape" then
		love.event.quit()
	end
end
function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key] or false
end
function love.draw()
	push:start()
	love.graphics.draw(background, -backgroundScroll, 0)
	love.graphics.draw(ground, -groundScroll, VH - 16)
	bird:render()
	for i, pair in ipairs(pipePairs) do
		pair:render()
	end
	push:finish()
end
