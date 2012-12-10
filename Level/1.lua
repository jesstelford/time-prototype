-- Declare a new class called Level_1
Level_1 = Class {

    inherits = Level_Abstract,

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self)

        Level_Abstract.construct(self, 10, 10, 10, 10)

        self:setTileTypeImage('wall', love.graphics.newImage('wall.png'))

        for x = 1, 10 do
            self:setMapValue(x, 1, Level_Abstract.TERRAIN_BLOCKED)
            self:setMapValue(x, 10, Level_Abstract.TERRAIN_BLOCKED)

            self:setTileValue(x, 1, 'wall')
            self:setTileValue(x, 10, 'wall')
        end

        for y = 2, 9 do
            self:setMapValue(1, y, Level_Abstract.TERRAIN_BLOCKED)
            self:setMapValue(10, y, Level_Abstract.TERRAIN_BLOCKED)

            self:setTileValue(1, y, 'wall')
            self:setTileValue(10, y, 'wall')
        end
    end
}

-- Required variable from Abstract class
Level_1.map = {}
Level_1.tiles = {}
Level_1.tileImages = {}
