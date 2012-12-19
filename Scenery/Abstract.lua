Scenery_Abstract = Class {

    name = 'Scenery_Abstract',
    inherits = Renderable_Image,

    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, image, positionX, positionY, renderOffsetX, renderOffsetY)
        Renderable_Image.construct(self, image, renderOffsetX, renderOffsetY)
        self.position = Vector(positionX, positionY)
        self.renderPosition = Vector(positionX, positionY)
    end
}
