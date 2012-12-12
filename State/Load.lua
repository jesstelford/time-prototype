-- 'static' style Load state
State_Load = Gamestate.new()

function State_Load:init()
    hamsterImage = love.graphics.newImage("media/images/hamster.png")
    player = Character_Player_Default(hamsterImage)
    levelOne = Level_1()
end

function State_Load:enter(previous)
    Gamestate.switch(State_Game)
end
