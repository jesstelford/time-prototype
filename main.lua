Class = require "hump.class"
Gamestate = require "hump.gamestate"

dofile("Player.lua")
dofile("State/Game.lua")

-- Called once before anything
function love.load()
    hamsterImage = love.graphics.newImage("hamster.png")
    player = Player(hamsterImage)
    Gamestate.switch(State_Game)
end

-- Called once per game loop
function love.update(dt)
    Gamestate.update(dt)
end

-- Called once per game loop
function love.draw()
    Gamestate.draw()
end
