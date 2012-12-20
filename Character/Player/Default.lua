Character_Player_Default = {} -- avoid circular dependancies
Character_Abstract = Character_Abstract or require "Character.Abstract"
Collidable_Box = Collidable_Box or require "Collidable.Box"

-- Declare a new class called Level_1
Character_Player_Default = Class {

    inherits = {Character_Abstract, Collidable_Box},
    name = 'Character_Player_Default',

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    -- @param positionX The Starting X Position of the character
    -- @param positionY The Starting Y Position of the character
    function(self, image, positionX, positionY)

        -- Call parent constructors
        Character_Abstract.construct(self, image, -image:getWidth() / 2, -image:getHeight() / 2)
        Collidable_Box.construct(self, positionX, positionY, image:getWidth(), image:getHeight())

        --- @var Store all the registered callbacks for later de-registering
        self.inputCallbacks = {}
    end
}

-- TODO: Record movements. Overload move functions, and log each movement
-- along with the frame?

-- TODO: Play back movements.

-- TODO: When playing back movements, have a force check to see if 'magic'
-- should happen or not. If not, and while all players being played back
-- simultaneously and cannot complete level, then Fail COndition triggered,
-- else Win Condition triggered.


function Character_Player_Default:registerForInput()

    -- Use a closure to correctly execute a method on a table (a class member method)
    local rightCallback = Signals.register('key-right', function(...) self:moveX(...) end)
    table.insert(self.inputCallbacks, rightCallback)

    local leftCallback = Signals.register('key-left', function(...) self:moveX(...) end)
    table.insert(self.inputCallbacks, leftCallback)

    local upCallback = Signals.register('key-up', function(...) self:moveY(...) end)
    table.insert(self.inputCallbacks, upCallback)

    local downCallback = Signals.register('key-down', function(...) self:moveY(...) end)
    table.insert(self.inputCallbacks, downCallback)

end

return Character_Player_Default
