--- Collidable class implementing Visitor Pattern
Collider = Class {
    name = 'Collider'
}

--- Default collision for two objects
function Collider:default(from, to)
    return nil
end

--- Check for collision between two circles
-- @param from Collidable_Circle The circle to collide 'from'
-- @param to Collidable_Circle The circle to collide 'to'
-- @return nil|Vector The vector normal of collision from 'from' in the direction of 'to'
function Collider:CircleToCircle(from, to)

    -- Correct type assertion
    assert(from:is_a(Collidable_Circle) and to:is_a(Collidable_Circle), "Both Collidable Objects must be Collidable_Circle's")

    centerFrom = from:getPosition()
    centerTo = to:getPosition()

    -- Use the squared distance to avoid a sqrt calculation
    distX = (centerTo.x - centerFrom.x)
    distY = (centerTo.y - centerFrom.y)
    distanceSquared = (distX * distX) + (distY * distY)

    minDistance = from:getCollisionRadius() + to:getCollisionRadius()

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

--- Check for collision between two boxes
-- @param from Collidable_Box The box to collide 'from'
-- @param to Collidable_Box The box to collide 'to'
-- @return nil|Vector The vector normal of collision from 'from' in the direction of 'to'
function Collider:BoxToBox(from, to)

    -- Correct type assertion
    assert(from:is_a(Collidable_Box) and to:is_a(Collidable_Box), "Both Collidable Objects must be Collidable_Box's")

    centerFrom = from:getPosition()
    centerTo = to:getPosition()

    sizeFrom = from:getCollisionSize()
    sizeTo = to:getCollisionSize()

    if (
        (math.abs(centerFrom.x - centerTo.x) * 2 < (sizeFrom.x + sizeTo.x))
        and (math.abs(centerFrom.y - centerTo.y) * 2 < (sizeFrom.y + sizeTo.y))
    ) then
        -- collision! :D
        -- TODO: Return some form of collision normal
        return Vector(0,0)
    end

    return nil
end
