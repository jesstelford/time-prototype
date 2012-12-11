-- Declare a new class called Level_Abstract
Level_Abstract = Class {

    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, map, tiles, tileWidth, tileHeight)

        self:setMap(map);
        self:setTiles(tiles);

        self.tileWidth = tileWidth
        self.tileHeight = tileHeight

    end
}

-- default class variables
-- Following must be copied to dervative class (due to tables being copied by
-- reference, rather than value to sub classes):
--
-- Level_Abstract.map = {}
-- Level_Abstract.tiles = {}
-- Level_Abstract.tileImages = {}

-- psuedo class constants
Level_Abstract.TERRAIN_PASSABLE = 0
Level_Abstract.TERRAIN_BLOCKED = 1

Level_Abstract.TILE_NONE = nil

-- public member functions
--- Check if the given coordinate is within the boundaries of the level's map
-- @param x (int)
-- @param y (int)
function Level_Abstract:inBounds(x, y)

    if x < 1 or x > self.mapWidth then
        return false
    end

    if y < 1 or y > self.mapHeight then
        return false
    end

    return true
end

--- @return level map's mapWidth
function Level_Abstract:getMapWidth()
    return self.mapWidth
end

--- @return level map's mapHeight
function Level_Abstract:getMapHeight()
    return self.mapHeight
end

--- Set the entire map, the height equates to the number of sub tables, and
-- the width is calculated as the length of the shortest sub table
-- @param map (table) a table of tables representing rows of the map. Will be
-- deep copied.
function Level_Abstract:setMap(map)

    -- deep copy of the map
    self.map = tree.clone(map)

    self.mapHeight = #self.map
    self.mapWidth = nil

    for y = 1, self.mapHeight do
        if self.mapWidth == nil or #self.map[y] < self.mapWidth then
            self.mapWidth = #self.map[y]
        end
    end
end

--- Set the tiles and their pixel sizes. Will perform a deep copy of the table
-- @param tiles (table) the tile Ids of the tiles map
-- @param tileWidth (int) the pixel width of each tile
-- @param tileHeight (int) the pixel height of each tile
function Level_Abstract:setTiles(tiles, tileWidth, tileHeight)
    self.tiles = tree.clone(tiles)
    self.tileWidth = tileWidth
    self.tileHeight = tileHeight
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

--- Set a value to the Level's map at the given coordinates
-- @param x (int)
-- @param y (int)
-- @param value (int)
function Level_Abstract:setTileValue(x, y, value)

    if not self:inBounds(x, y) then
        error()
    end

    self.tiles[y][x] = value
end

function Level_Abstract:setTileTypeImage(value, image)
    self.tileImages[value] = image
end

function Level_Abstract:draw()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- only if an image has been set for this tile type
            if self.tileImages[self.tiles[y][x]] ~= nil then
                local drawX = (x - 1) * self.tileWidth
                local drawY = (y - 1) * self.tileHeight
                love.graphics.draw(self.tileImages[self.tiles[y][x]], drawX, drawY)
            end
        end
    end
end
