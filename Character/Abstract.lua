-- Abstract character class containing basic functionality for all characters
-- in the game (enemies, players, etc)
Character_Abstract = Class {
    name = 'Character_Abstract',
    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        self.image = image
    end
}

-- default class variables, must be copied to derivative classes, and renamed
-- to be the correct class
-- Character_Abstract.pos = {x=0,y=0}

-- public member functions

--- Move the character in the X axis
-- @param dist (float) The distance in pixels to move
function Character_Abstract:moveX(dist)
    self.pos.x = self.pos.x + dist;
end

--- Move the character in the Y axis
-- @param dist (float) The distance in pixels to move
function Character_Abstract:moveY(dist)
    self.pos.y = self.pos.y + dist;
end

--- Draw the character on the screen based on current position
function Character_Abstract:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end
