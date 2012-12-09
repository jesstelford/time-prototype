-- Player class
Player = Class {
    function(self, image)
        -- constructor
        self.image = image
    end
}

Player.pos = {
    x = 100,
    y = 100
}

function Player:moveX(dist)
    self.pos.x = self.pos.x + dist;
end

function Player:moveY(dist)
    self.pos.y = self.pos.y + dist;
end

function Player:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end
-- END Player class
