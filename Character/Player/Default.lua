-- Declare a new class called Level_1
Character_Player_Default = Class {

    inherits = Character_Abstract,

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        Character_Abstract.construct(self, image)

        self:registerForInput()
    end
}

-- Required variable from Abstract class
Character_Player_Default.pos = {x=300,y=300}

-- local variables
Character_Player_Default.inputCallbacks = {}

-- TODO: Record movements. Overload move functions, and log each movement
-- along with the frame?

-- TODO: Play back movements.

-- TODO: When playing back movements, have a force check to see if 'magic'
-- should happen or not. If not, and while all players being played back
-- simultaneously and cannot complete level, then Fail COndition triggered,
-- else Win Condition triggered.


function Character_Player_Default:registerForInput()

    local rightCallback = Signals.register('key-right', self.moveX, self)
    table.insert(self.inputCallbacks, rightCallback)

    local leftCallback = Signals.register('key-left', self.moveX, self)
    table.insert(self.inputCallbacks, leftCallback)

    local upCallback = Signals.register('key-up', self.moveY, self)
    table.insert(self.inputCallbacks, upCallback)

    local downCallback = Signals.register('key-down', self.moveY, self)
    table.insert(self.inputCallbacks, downCallback)

end
