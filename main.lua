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

require("StateMachine")
require("states.BaseState")
require("states.CountDownState")
require("states.PlayState")
require("states.TitleState")
require("states.ScoreState")

local backgroundScroll = 0
local groundScroll = 0
-- parallex effect as ground is closer than background so ground scrolls faster than background
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413
local GROUND_LOOPING_POINT = 514
function love.load()
	love.window.setTitle("Fifty Bird")
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())

	smallFont = love.graphics.newFont("font.ttf", 8)
	mediumFont = love.graphics.newFont("flappy.ttf", 14)
	flappyFont = love.graphics.newFont("flappy.ttf", 28)
	hugeFont = love.graphics.newFont("flappy.ttf", 56)
	love.graphics.setFont(flappyFont)

	background = love.graphics.newImage("background.png")
	ground = love.graphics.newImage("ground.png")

	gsm = StateMachine({
		["title"] = function()
		return TitleState()
		end,
		["play"] = function()
		return PlayState()
		end,
		["score"] = function()
		return ScoreState()
		end,
		['countdown'] = function()
		return Countdown()
		end
	}, "title")
	love.keyboard.keysPressed = {}

	love.window.setMode(WW, WH, { resizable = false, vsync = true, fullscreen = false })
	push:setupScreen(VW, VH, WW, WH)
end
function love.update(dt)
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT
	gsm:update(dt)
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
	gsm:render()
	push:finish()
end
