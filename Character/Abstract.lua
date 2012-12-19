-- Abstract character class containing basic functionality for all characters
-- in the game (enemies, players, etc)
Character_Abstract = Class {

    name = 'Character_Abstract',
    inherits = Renderable,

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        self.image = image
        self.position = Vector(0,0)
    end
}

--- Move the character in the X axis
-- @param dist (float) The distance in pixels to move
function Character_Abstract:moveX(dist)
    self.position.x = self.position.x + dist;
end

--- Move the character in the Y axis
-- @param dist (float) The distance in pixels to move
function Character_Abstract:moveY(dist)
    self.position.y = self.position.y + dist;
end

function Character_Abstract:getImage()
    return self.image
end

function Character_Abstract:getRenderPosition()
    return Vector(self.position.x - (self.image:getWidth() / 2), self.position.y - (self.image:getHeight() / 2))
end
