Scenery_Wall = {} -- avoid circular dependancies
Scenery_Abstract = Scenery_Abstract or require "Scenery.Abstract"
Collidable_Box = Collidable_Box or require "Collidable.Box"

Scenery_Wall = Class {

    name = 'Scenery_Wall',
    inherits = {Scenery_Abstract, Collidable_Box},

    function(self, image, positionX, positionY)
        Collidable_Box.construct(self, positionX, positionY, image:getWidth(), image:getHeight())
        Scenery_Abstract.construct(self, image, positionX, positionY, -image:getWidth() / 2, -image:getHeight() / 2)
    end
}

return Scenery_Wall
