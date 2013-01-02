Collider = {} -- avoid circular dependancies
HardonCollider = HardonCollider or require "hardoncollider".HardonCollider

Collider = Class {
    name = 'Collider',
    inherits = HardonCollider,
    function(self, cell_size)
        HardonCollider.construct(
            self,
            cell_size,
            function(...) self:collisionBegin(...) end,
            function(...) self:collisionEnd(...) end
        )
    end
}

function Collider:collisionBegin(deltaTime, shapeTo, shapeFrom, penetrationX, penetrationY)
    shapeFrom:addCollisionNormal(Vector(penetrationX, penetrationY), shapeTo)
end

function Collider:collisionEnd(deltaTime, shapeTo, shapeFrom)
    shapeFrom:removeCollisionNormal(shapeTo)
end

return Collider
