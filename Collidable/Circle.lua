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

Collidable_Circle.position = Vector(0,0)
Collidable_Circle.radius = 1

function Collidable_Circle:getRadius()
    return self.radius
end
