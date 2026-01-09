local square = {
	x = 0,
	y = 0,
	width = 20,
	height = 20,
	color = { 255, 0, 0 },
}

function love.load()
	return square
end

function love.update(dt)
	square.x = square.x + dt
end

function love.draw()
	love.graphics.setColor(unpack(square.color))
	love.graphics.rectangle("fill", square.x, square.y, square.width, square.height)
end
