-- Declare a new class called Level_Abstract
Level_Abstract = Class {

    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, width, height)
        self.width = width
        self.height = height

        -- Reset the map to all 'Passable'
        self.map = {}
        for y = 1, height do
            self.map[y] = {}
            for x = 1, width do
                self.map[y][x] = Level_Abstract.TERRAIN_PASSABLE
            end
        end

    end
}

-- default class variables
-- Following must be copied to dervative class (due to tables being copied by
-- reference, rather than value to sub classes):
--
-- Level_Abstract.map = {}

-- psuedo class constants
Level_Abstract.TERRAIN_PASSABLE = 1
Level_Abstract.TERRAIN_BLOCKED = 2

-- public member functions
--- Check if the given coordinate is within the boundaries of the level's map
-- @param x (int)
-- @param y (int)
function Level_Abstract:inBounds(x, y)

    if x < 1 or x > self.width then
        return false
    end

    if y < 1 or y > self.height then
        return false
    end

    return true
end

--- Set a value to the Level's map at the given coordinates
-- @param x (int)
-- @param y (int)
-- @param value (int)
function Level_Abstract:setMapValue(x, y, value)

    if not self:inBounds(x, y) then
        error()
    end

    self.map[y][x] = value
end

--- @param x (int)
-- @param y (int)
-- @return boolean true if coordinate passable
function Level_Abstract:isMapPassable(x, y)
    if not self:inBounds(x, y) then
        error()
    end

    if self.map[y][x] == Level_Abstract.TERRAIN_PASSABLE then
        return true
    else
        return false
    end
end

--- @return level map's width
function Level_Abstract:getWidth()
    return self.width
end

--- @return level map's height
function Level_Abstract:getHeight()
    return self.height
end
