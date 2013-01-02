Character_Player_Default = {} -- avoid circular dependancies
Character_Abstract = Character_Abstract or require "Character.Abstract"
Collidable_Abstract = Collidable_Abstract or require "Collidable.Abstract"
Collidable_Polygon = Collidable_Polygon or require "hardoncollider.polygon"
Collidable_Shapes = Collidable_Shapes or require "hardoncollider.shapes"

-- Declare a new class called Level_1
Character_Player_Default = Class {

    inherits = {Character_Abstract, Collidable_Abstract, Collidable_Shapes.ConvexPolygonShape},
    name = 'Character_Player_Default',

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    -- @param positionX The Starting X Position of the character
    -- @param positionY The Starting Y Position of the character
    function(self, image, positionX, positionY)

        local halfWidth = image:getWidth() / 2
        local halfHeight = image:getHeight() / 2

        -- Call parent constructors
        Character_Abstract.construct(self, image, -halfWidth, -halfHeight)
        Collidable_Abstract.construct(self, positionX, positionY)

        Collidable_Shapes.ConvexPolygonShape.init(
            self,
            Collidable_Polygon(
                positionX - halfWidth, positionY - halfHeight,
                positionX + halfWidth, positionY - halfHeight,
                positionX + halfWidth, positionY + halfHeight,
                positionX - halfWidth, positionY + halfHeight
            )
        )

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
    local rightCallback = Signals.register('key-right', function(x, ...) self:moveX(x) self:move(x, 0) end)
    table.insert(self.inputCallbacks, rightCallback)

    local leftCallback = Signals.register('key-left', function(x, ...) self:moveX(x) self:move(x, 0) end)
    table.insert(self.inputCallbacks, leftCallback)

    local upCallback = Signals.register('key-up', function(y, ...) self:moveY(y) self:move(0, y) end)
    table.insert(self.inputCallbacks, upCallback)

    local downCallback = Signals.register('key-down', function(y, ...) self:moveY(y) self:move(0, y) end)
    table.insert(self.inputCallbacks, downCallback)

end

return Character_Player_Default
