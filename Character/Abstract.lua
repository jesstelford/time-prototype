-- Abstract character class containing basic functionality for all characters
-- in the game (enemies, players, etc)
Character_Abstract = Class {

    name = 'Character_Abstract',

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

--- Draw the character on the screen based on current position
function Character_Abstract:draw()
    love.graphics.draw(self.image, self.position.x - (self.image:getWidth() / 2), self.position.y - (self.image:getHeight() / 2))
end
