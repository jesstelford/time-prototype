--- Collidable class implementing Visitor Pattern
Collidable_Abstract = Class {
    name = 'Collidable_Abstract',
    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, xPosition, yPosition)
        self.position = Vector(xPosition, yPosition)
    end
}

-- variables that implementing classes must define
-- Collidable_Abstract.position = Vector(0,0)

function Collidable_Abstract:collideWith(collidable)
    -- must be of type Collidable_Abstract to collide with
    assert(collidable:is_a(Collidable_Abstract), 'Can only collide with Collidable objects')

    collider = Collider()

    fromType = self.getCollidableType()
    toType = self.getCollidableType()

    funcName = fromType .. 'To' .. toType
    if type(collider[funcName]) == 'function' then
        return collider[funcName](collider, self, collidable)
    else
        funcName = toType .. 'To' .. fromType
        if type(collider[funcName]) == 'function' then
            return collider[funcName](collider, collidable, self)
        else
            return collider:default(self, collidable)
        end
    end

end

function Collidable_Abstract:getPosition()
    return self.position
end

function Collidable_Abstract:getCollidableType()
    return 'Abstract'
end
