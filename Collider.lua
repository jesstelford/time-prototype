--- Collidable class implementing Visitor Pattern
Collider = Class {
    name = 'Collider'
}

--- Check for collision between two circles
-- @param from Collidable_Circle The circle to collide 'from'
-- @param to Collidable_Circle The circle to collide 'to'
-- @return nil|Vector The vector normal of collision from 'from' in the direction of 'to'
function Collider:CircleToCircle(from, to)

    -- Correct type assertion
    assert(from:is_a('Collidable_Circle') and to:is_a('Collidable_Circle'), "Both Collidable Objects must be Collidable_Circle's")

    centerFrom = from:getPosition()
    centerTo = to:getPosition()

    -- Use the squared distance to avoid a sqrt calculation
    distX = (centerTo.x - centerFrom.x)
    distY = (centerTo.y - centerFrom.y)
    distanceSquared = (distX * distX) + (distY * distY)

    minDistance = from:getRadius() + to:getRadius()

    -- ensure we square both sides of the equation, and check for difference
    if distanceSquared < (minDistance * minDistance) then
        -- collision
        -- generate a normal going 'from' to 'to'
        normal = Vector(distX, distY)
        normal:normalize_inplace()
        return normal
    end

    return nil
end
