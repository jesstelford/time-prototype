-- Declare a new class called Player
Player = Class {
    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        self.image = image
    end
}

-- default class variables
Player.pos = {
    x = 100,
    y = 100
}

-- public member functions

--- Move the player in the X axis
-- @param dist (float) The distance in pixels to move
function Player:moveX(dist)
    self.pos.x = self.pos.x + dist;
end

--- Move the player in the Y axis
-- @param dist (float) The distance in pixels to move
function Player:moveY(dist)
    self.pos.y = self.pos.y + dist;
end

--- Draw the player on the screen based on current position
function Player:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end
