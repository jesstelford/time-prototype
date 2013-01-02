Scenery_Wall = {} -- avoid circular dependancies
Scenery_Abstract = Scenery_Abstract or require "Scenery.Abstract"
Collidable_Abstract = Collidable_Abstract or require "Collidable.Abstract"
Collidable_Polygon = Collidable_Polygon or require "hardoncollider.polygon"
Collidable_Shapes = Collidable_Shapes or require "hardoncollider.shapes"

Scenery_Wall = Class {

    name = 'Scenery_Wall',
    inherits = {Scenery_Abstract, Collidable_Abstract, Collidable_Shapes.ConvexPolygonShape},

    function(self, image, positionX, positionY)

        local halfWidth = image:getWidth() / 2
        local halfHeight = image:getHeight() / 2

        Collidable_Abstract.construct(self, positionX, positionY)

        Collidable_Shapes.ConvexPolygonShape.init(
            self,
            Collidable_Polygon(
                positionX - halfWidth, positionY - halfHeight,
                positionX + halfWidth, positionY - halfHeight,
                positionX + halfWidth, positionY + halfHeight,
                positionX - halfWidth, positionY + halfHeight
            )
        )

        Scenery_Abstract.construct(self, image, positionX, positionY, -halfWidth, -halfHeight)

    end
}

return Scenery_Wall
