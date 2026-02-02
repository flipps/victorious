function love.load()
	anim8 = require("lib/anim8")
	love.graphics.setDefaultFilter("nearest", "nearest")

	player = {}
	player.x = 400
	player.y = 200
	player.speed = 1

	player.state = "idle"
	player.direction = "down"

	player.sprite = love.graphics.newImage("sprites/orc_walk.png")
	player.idle_sprite = love.graphics.newImage("sprites/orc_idle.png")
	player.grid = anim8.newGrid(64, 64, player.sprite:getWidth(), player.sprite:getHeight())
	player.idle_grid = anim8.newGrid(64, 64, player.idle_sprite:getWidth(), player.idle_sprite:getHeight())

	player.animations = {
		walk = {},
		idle = {},
	}

	player.animations.walk.down = anim8.newAnimation(player.grid:getFrames("1-6", 1), 0.2)
	player.animations.walk.up = anim8.newAnimation(player.grid:getFrames("1-6", 2), 0.2)
	player.animations.walk.left = anim8.newAnimation(player.grid:getFrames("1-6", 3), 0.2)
	player.animations.walk.right = anim8.newAnimation(player.grid:getFrames("1-6", 4), 0.2)

	player.animations.idle.down = anim8.newAnimation(player.idle_grid:getFrames("1-4", 1), 0.2)
	player.animations.idle.up = anim8.newAnimation(player.idle_grid:getFrames("1-4", 2), 0.2)
	player.animations.idle.left = anim8.newAnimation(player.idle_grid:getFrames("1-4", 3), 0.2)
	player.animations.idle.right = anim8.newAnimation(player.idle_grid:getFrames("1-4", 4), 0.2)

	player.anim = player.animations.idle.down
end

function love.update(dt)
	local isMoving = false

	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed
		player.direction = "right"
		isMoving = true
	end
	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed
		player.direction = "left"
		isMoving = true
	end
	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed
		player.direction = "up"
		isMoving = true
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed
		player.direction = "down"
		isMoving = true
	end

	if isMoving then
		if player.state ~= "walk" then
			player.state = "walk"
			player.anim = player.animations.walk[player.direction]
			player.anim:gotoFrame(1)
		end
	else
		if player.state ~= "idle" then
			player.state = "idle"
			player.anim = player.animations.idle[player.direction]
			player.anim:gotoFrame(1)
		end
	end

	player.anim:update(dt)
end

function love.draw()
	player.anim:draw(player.state == "idle" and player.idle_sprite or player.sprite, player.x, player.y, nil, 2)
end
