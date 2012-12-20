Collidable_Box = {} -- avoid circular dependancies
Collidable_Abstract = Collidable_Abstract or require "Collidable.Abstract"

--- Collidable class implementing Visitor Pattern
Collidable_Box = Class {

    name = 'Collidable_Box',
    inherits = Collidable_Abstract,

    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, xPosition, yPosition, xSize, ySize)
        Collidable_Abstract.construct(self, xPosition, yPosition)
        self.size = Vector(xSize, ySize)
    end
}

function Collidable_Box:getCollisionSize()
    return self.size
end

function Collidable_Box:getCollidableType()
    return 'Box'
end

return Collidable_Box
