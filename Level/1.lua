-- Declare a new class called Level_1
Level_1 = Class {

    inherits = Level_Abstract,

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self)
        Level_Abstract.construct(self, 10, 10)

        for x = 1, 10 do
            self:setMapValue(x, 1, Level_Abstract.TERRAIN_BLOCKED)
            self:setMapValue(x, 10, Level_Abstract.TERRAIN_BLOCKED)
        end

        for y = 2, 9 do
            self:setMapValue(1, y, Level_Abstract.TERRAIN_BLOCKED)
            self:setMapValue(10, y, Level_Abstract.TERRAIN_BLOCKED)
        end
    end
}

-- Required variable from Abstract class
Level_1.map = {}