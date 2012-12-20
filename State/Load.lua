State_Load = {} -- avoid circular dependancies
State_Game = State_Game or require "State.Game"
Level_1 = Level_1 or require "Level.1"

-- 'static' style Load state
State_Load = Gamestate.new()

function State_Load:init()
    levelOne = Level_1()
end

function State_Load:enter(previous)
    Gamestate.switch(State_Game)
end

return State_Load
