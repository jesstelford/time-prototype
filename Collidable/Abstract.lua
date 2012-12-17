--- Collidable class implementing Visitor Pattern
Collidable_Abstract = Class {
    name = 'Collidable_Abstract',
    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, xPosition, yPosition)
        self.position.x = xPosition
        self.position.y = yPosition
    end
}

-- variables that implementing classes must define
-- Collidable_Abstract.position = vector(0,0)

function Collidable_Abstract:collideWith(collidable)
    -- must be of type Collidable_Abstract to collide with
    assert(collidable:is_a('Collidable_Abstract'), 'Can only collide with Collidable objects')

    collider = Collider()

    funcName = self.name .. 'To' .. col.name
    if type(collider[funcName]) == 'function' then
        return collider[funcName](collider, self, col)
    else
        funcName = col.name .. 'To' .. self.name
        if type(collider[funcName]) == 'function' then
            return collider[funcName](collider, col, self)
        else
            return collider:default(self, col)
        end
    end

end

function Collidable_Abstract:getPosition()
    return self.position
end
