-- Abstract character class containing basic functionality for all characters
-- in the game (enemies, players, etc)
Character_Abstract = Class {

    name = 'Character_Abstract',
    inherits = Renderable_Image,

    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, image, renderOffsetX, renderOffsetY)
        self.position = Vector(0,0)
        Renderable_Image.construct(self, image, renderOffsetX, renderOffsetY)
    end
}

--- Move the character in the X axis
-- @param dist (float) The distance in pixels to move
function Character_Abstract:moveX(dist)
    self.position.x = self.position.x + dist
end

--- Move the character in the Y axis
-- @param dist (float) The distance in pixels to move
function Character_Abstract:moveY(dist)
    self.position.y = self.position.y + dist
end

--- Update any information that is required for rendering (see the inherited
-- Renderable_Image class for more)
function Character_Abstract:updateRenderData()
    self.renderPosition.x = self.position.x
    self.renderPosition.y = self.position.y
end
