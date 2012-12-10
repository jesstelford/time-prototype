-- 'static' style Game state
State_Game = Gamestate.new()

function State_Game:init()
    -- Set a variable on the game state object
    State_Game.speed = 100
end

function State_Game:enter(previous)
end

function State_Game:update(dt)

    local dist = (State_Game.speed * dt)

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

function State_Game:draw()
    player:draw()

    local string = ""
    for y = 1, levelOne:getMapHeight() do
        string = string .. table.concat(levelOne.map[y], ',') .. "\n"
    end

    love.graphics.print(string, 10, 10)
end
