-- Declare a new class called Level_Abstract
Level_Abstract = Class {

    --- Constructor
    -- @param self A reference to the object being constructed
    function(self, tileWidth, tileHeight)

        -- Set the member variables for this instance
        self.map = {}
        self.tiles = {}
        self.tileImages = {}
        self.enemies = {}
        self.obstacles = {}
        self.players = {}
        self.drawOffset = Vector(10,10)
        self.currentPlayerIndex = nil

        self.tileWidth = tileWidth
        self.tileHeight = tileHeight

    end
}

-- psuedo class constants
Level_Abstract.TERRAIN_PASSABLE = 0
Level_Abstract.TERRAIN_BLOCKED = 1

Level_Abstract.TILE_NONE = nil
Level_Abstract.TILE_WALL = 1

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
    self:setMapDimensionsFromTableSize(self.map)

end

function Level_Abstract:setMapDimensionsFromTableSize(table)

    self.mapHeight = #table
    self.mapWidth = nil

    for y = 1, self.mapHeight do
        if self.mapWidth == nil or #table[y] < self.mapWidth then
            self.mapWidth = #self.map[y]
        end
    end
end

--- Set the tiles and their pixel sizes. Will perform a deep copy of the table
-- @param tiles (table) the tile Ids of the tiles map
-- @param tileWidth (int) the pixel width of each tile
-- @param tileHeight (int) the pixel height of each tile
function Level_Abstract:setTiles(tiles, tileWidth, tileHeight)

    self:setMapDimensionsFromTableSize(tiles)

    self.tileWidth = tileWidth
    self.tileHeight = tileHeight

    for y = 1, self.mapWidth do
        for x = 1, self.mapHeight do
            self:setTileValue(x, y, tiles[y][x])
        end
    end
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
        error('Map coordinates out of bounds')
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

function Level_Abstract:update()

    local player = self:getCurrentPlayer()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            if not self:isMapPassable(x, y) then
                local xCenter = self.tileWidth * (x - 1) + self.drawOffset.x
                local yCenter = self.tileHeight * (y - 1) + self.drawOffset.y
                local wallCollider = Collidable_Box(xCenter, yCenter, self.tileWidth, self.tileHeight)
                normal = wallCollider:collideWith(player)
                if normal ~= nil then
                    print(normal)
                end
            end
        end
    end
end

function Level_Abstract:draw()
    self:drawTiles()
    self:drawEnemies()
    self:drawObstacles()
    self:drawPlayers()
    self:drawCollisionDebug()
end

function Level_Abstract:drawTiles()

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- only if an image has been set for this tile type
            if self.tileImages[self.tiles[y][x]] ~= nil then
                local drawX = self.tileWidth * (x - 1.5) + self.drawOffset.x
                local drawY = self.tileHeight * (y - 1.5) + self.drawOffset.y
                love.graphics.draw(self.tileImages[self.tiles[y][x]], drawX, drawY)
            end
        end
    end

end

function Level_Abstract:drawCollisionDebug()

    renderer = Renderer_Collision()

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- only if an image has been set for this tile type
            if not self:isMapPassable(x, y) then
                local drawX = self.tileWidth * (x - 1.5) + self.drawOffset.x
                local drawY = self.tileHeight * (y - 1.5) + self.drawOffset.y
                love.graphics.rectangle('line', drawX, drawY, self.tileWidth, self.tileHeight)
            end
        end
    end

    for i = 1, #self.players do
        self.players[i]:renderTo(renderer)
    end
end

function Level_Abstract:drawEnemies()
    renderer = Renderer_Image()
    for i = 1, #self.enemies do
        self.enemies[i]:updateRenderData()
        self.enemies[i]:renderTo(renderer)
    end
end

function Level_Abstract:drawObstacles()
    for i = 1, #self.obstacles do
        self.obstacles[i]:updateRenderData()
        self.obstacles[i]:draw()
    end
end

function Level_Abstract:drawPlayers()
    renderer = Renderer_Image()
    for i = 1, #self.players do
        self.players[i]:updateRenderData()
        self.players[i]:renderTo(renderer)
    end
end

function Level_Abstract:addEnemy(enemy)
    table.insert(self.enemies, enemy)
end

function Level_Abstract:getEnemies()
    return self.enemies
end

function Level_Abstract:addObstacle(obstacle)
    table.insert(self.obstacles, obstacle)
end

function Level_Abstract:getObstacles()
    return self.obstacles
end

function Level_Abstract:addPlayer(player)

    table.insert(self.players, player)

    -- update which player is the current player if not already set
    if self.currentPlayerIndex == nil then
        self.currentPlayerIndex = #self.players
    end

end

function Level_Abstract:getPlayers()
    return self.players
end

function Level_Abstract:getCurrentPlayer()

    if self.currentPlayerIndex == nil then
        error('No current player set.')
    end

    return self.players[self.currentPlayerIndex]
end
