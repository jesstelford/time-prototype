Renderable_Image = {} -- avoid circular dependancies
Renderable_Abstract = Renderable_Abstract or require "Renderable.Abstract"

Renderable_Image = Class {
    inherits = Renderable_Abstract,

    function(self, image, renderOffsetX, renderOffsetY)

        Renderable_Abstract.construct(self)

        self.image = image
        self.renderPosition = Vector(0,0)
        self.renderOffset = Vector(renderOffsetX, renderOffsetY)
    end
}

--- Get the love image
-- @return Image
function Renderable_Image:getImage()
    return self.image
end

--- The coordinates of the top-left render position
-- @return Vector
function Renderable_Image:getRenderPosition()
    return Vector(self.renderPosition.x + self.renderOffset.x, self.renderPosition.y + self.renderOffset.y)
end

return Renderable_Image
