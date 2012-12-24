Collidable_Abstract = {} -- avoid circular dependancies
Collider = Collider or require "Collider"

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

function Collidable_Abstract:collideWith(collidable)
    -- must be of type Collidable_Abstract to collide with
    assert(collidable:is_a(Collidable_Abstract), 'Can only collide with Collidable objects')

    collider = Collider()

    fromType = self.getCollidableType()
    toType = collidable.getCollidableType()

    funcName = fromType .. 'To' .. toType
    if type(collider[funcName]) == 'function' then
        collisionNormal = collider[funcName](collider, self, collidable)
        if collisionNormal ~= nil then
            self:addCollisionNormal(collisionNormal)
            collidable:addCollisionNormal(collisionNormal * -1)
        end
    else

        funcName = toType .. 'To' .. fromType

        if type(collider[funcName]) == 'function' then

            collidable.collisionNormal = collider[funcName](collider, collidable, self)

            if collisionNormal ~= nil then
                self:addCollisionNormal(collisionNormal * -1)
                collidable:addCollisionNormal(collisionNormal)
            end
        else
            self.collisionNormal = collider:default(self, collidable)
            if collisionNormal ~= nil then
                self:addCollisionNormal(collisionNormal)
                collidable:addCollisionNormal(collisionNormal * -1)
            end
        end
    end

    return self.collisionNormal
end

function Collidable_Abstract:getPosition()
    return self.position
end

function Collidable_Abstract:getCollidableType()
    return 'Abstract'
end

function Collidable_Abstract:addCollisionNormal(normal)
    table.insert(self.collisionNormals, normal)
end

function Collidable_Abstract:getCollisionNormals()
    return self.collisionNormals
end

function Collidable_Abstract:isColliding()
    return #self.collisionNormals > 0
end

function Collidable_Abstract:resetCollisionState()
    self.collisionNormals = {}
end

return Collidable_Abstract
