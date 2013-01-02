Collidable_Abstract = {} -- avoid circular dependancies

--- Collidable class implementing Visitor Pattern
Collidable_Abstract = Class {
    name = 'Collidable_Abstract',
    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, xPosition, yPosition)
        self.position = Vector(xPosition, yPosition)
        self.collisionNormals = {}
    end
}

function Collidable_Abstract:getPosition()
    return self.position
end

function Collidable_Abstract:addCollisionNormal(normal, shape)
    self.collisionNormals[shape] = normal
end

function Collidable_Abstract:removeCollisionNormal(shape)
    self.collisionNormals[shape] = nil
end

function Collidable_Abstract:getCollisionNormals()
    return self.collisionNormals
end

function Collidable_Abstract:isColliding()
    for key, value in pairs(self.collisionNormals) do
        if value ~= nil then
            return true
        end
    end

    return false
end

return Collidable_Abstract
