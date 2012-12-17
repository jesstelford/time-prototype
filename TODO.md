# Collisions
## Visitor Pattern

Create a Collidable class that has methods:
 * collideWith(Collidable)
 * getPosition()
 * create sub classes which implement different functions:
   * CollidableBox:
     * getWidth()
     * getHeight()
   * CollidableCircle:
     * getRadius()
   * CollidableRotatedBox:
     * getWidth()
     * getHeight()
     * getAngle()
   * CollidablePolygon
     * getPolygon()

Create a Collider class that contains all the logic for handling a collition:
 * boxToBox(Collidable box, Collidable box)
 * boxToCircle(Collidable box, Collidable circle)
 * boxToRotatedBox(Collidable box, Collidable rotatedBox)
 * boxToPolygon(Collidable box, Collidable polygon)
 * circleToCircle(Collidable circle, Collidable circle)
 * circleToRotatedBox(Collidable circle, Collidable rotatedBox)
 * circleToPolygon(Collidable circle, Collidable polygon)
 * rotatedBoxToRotatedBox(Collidable rotatedBox, Collidable rotatedBox)
 * rotatedBoxToPolygon(Collidable rotatedBox, Collidable polygon)

Collidable's collideWith() function then looks something like:

    function collideWith(Collidable col)
        collider = Collider()
        funcName = type(self) .. 'To' .. type(col)
        if type(collider[funcName]) == 'function'
            return collider[funcName](collider, self, col)
        else
            funcName = type(col) .. 'To' .. type(self)
            if type(collider[funcName]) == 'function'
                return collider[funcName](collider, col, self)
            else
                return collider:default(self, col)
            end
        end
    end
