WW = 1280
WH = 720
VW = 512
VH = 288
HVW = VW / 2
HVH = VH / 2
local backgroundScroll = 0
local groundScroll = 0
-- parallex effect as ground is closer than background so ground scrolls faster than background
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local pipes = {}
local spawnTimer = 0
local BACKGROUND_LOOPING_POINT = 413
push = require("push")
Class = require("class")
require("Bird")
require("Pipe")
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
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VW
	spawnTimer = spawnTimer + dt
	if spawnTimer > 2 then
		table.insert(pipes, Pipe())
		spawnTimer = 0
	end
	bird:update(dt)
	for k, pipe in pairs(pipes) do
		pipe:update(dt)
		if pipe.x < -pipe.width then
			table.remove(pipes, k)
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
	for k, pipe in pairs(pipes) do
		pipe:render()
	end
	push:finish()
end
