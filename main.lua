Class = require "hump.class"
dofile("Player.lua")

-- Called once before anything
function love.load()
    hamsterImage = love.graphics.newImage("hamster.png")
    speed = 100 
    player = Player(hamsterImage)
end

-- Called once per game loop
function love.update(dt)

    local dist = (speed * dt)

    if love.keyboard.isDown("right") then
        player:moveX(dist)
    elseif love.keyboard.isDown("left") then
        player:moveX(-dist)
    end 

    if love.keyboard.isDown("up") then
        player:moveY(-dist)
    elseif love.keyboard.isDown("down") then
        player:moveY(dist)
    end 

end

-- Called once per game loop
function love.draw()
    player:draw()
end
