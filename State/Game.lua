-- 'static' style Game state
State_Game = Gamestate.new()

function State_Game:init()
    -- Set a variable on the game state object
    State_Game.speed = 100
end

function State_Game:enter(previous)
end

function State_Game:update(dt)

    levelOne:update(dt)

    local dist = (State_Game.speed * dt)

    if love.keyboard.isDown("right") then
        Signals.emit('key-right', dist)
    elseif love.keyboard.isDown("left") then
        Signals.emit('key-left', -dist)
    end 

    if love.keyboard.isDown("up") then
        Signals.emit('key-up', -dist)
    elseif love.keyboard.isDown("down") then
        Signals.emit('key-down', dist)
    end 

end

function State_Game:draw()

    levelOne:draw()

end

return State_Game
