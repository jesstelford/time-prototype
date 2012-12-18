--- Collidable class implementing Visitor Pattern
Collidable_Circle = Class {
    name = 'Collidable_Circle',
    inherits = Collidable_Abstract,
    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, xPosition, yPosition, radius)
        Collidable_Abstract.construct(self, xPosition, yPosition)
        self.radius = radius
    end
}

function Collidable_Circle:getCollisionRadius()
    return self.radius
end

function Collidable_Circle:getCollidableType()
    return 'Circle'
end
