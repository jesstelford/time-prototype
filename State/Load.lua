-- 'static' style Load state
State_Load = Gamestate.new()

function State_Load:init()
    hamsterImage = love.graphics.newImage("hamster.png")
    player = Player(hamsterImage)
    levelOne = Level_1()
end

function State_Load:enter(previous)
    Gamestate.switch(State_Game)
end
