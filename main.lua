package.path = love.filesystem.getWorkingDirectory( ) .. '/?.lua;' .. package.path
Class = require "hump.class"
Gamestate = require "hump.gamestate"
Signals = require "hump.signal"
Vector = require "hump.vector"

require "std"

require "State.Load"

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
