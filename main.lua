Class = require "hump.class"
Gamestate = require "hump.gamestate"

require "Player"
require "State.Load"
require "State.Game"

require "Level.Abstract"
require "Level.1"

-- Called once before anything
function love.load()
    Gamestate.switch(State_Load)
end

-- Called once per game loop
function love.update(dt)
    Gamestate.update(dt)
end

-- Called once per game loop
function love.draw()
    Gamestate.draw()
end
