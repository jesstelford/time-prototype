Class = require "hump.class"
Gamestate = require "hump.gamestate"
Signals = require "hump.signal"
Vector = require "hump.vector"

require "std"

require "Character.Abstract"
require "Character.Player.Default"
require "Character.Enemy.Default"

require "Level.Abstract"
require "Level.1"

require "State.Load"
require "State.Game"

require "Collider"
require "Collidable.Abstract"
require "Collidable.Circle"

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
