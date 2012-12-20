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

    if value ~= nil and self.tileImages[value] ~= nil then

        local drawX = self.tileWidth * (x - 1.5) + self.drawOffset.x
        local drawY = self.tileHeight * (y - 1.5) + self.drawOffset.y

        if self.tiles[y] == nil then
            self.tiles[y] = {}
        end

        if value == Level_Abstract.TILE_WALL then

            -- set the tile
            self.tiles[y][x] = Scenery_Wall(self.tileImages[value], drawX, drawY)

        -- elseif tiles[y][x] == Level_Abstract.TILE_SOMETHING then
        --     self.tiles[y][x] = Scenery_Something()
        end

    end
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

    renderer = Renderer_Image()

    self:_renderTiles(renderer)

    self:_renderRenderableImageTable(self.enemies, renderer)
    self:_renderRenderableImageTable(self.players, renderer)

    self:drawCollisionDebug()
end

function Level_Abstract:drawCollisionDebug()
    renderer = Renderer_Collision()
    self:_renderTiles(renderer)
    self:_renderRenderableImageTable(self.players, renderer)
end

function Level_Abstract:_renderTiles(renderer)

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- only if this tile has been set
            if self.tiles[y][x] ~= nil then
                self.tiles[y][x]:renderTo(renderer)
            end
        end
    end
end

function Level_Abstract:_renderRenderableImageTable(table, renderer)
    for i = 1, #table do
        table[i]:updateRenderData()
        table[i]:renderTo(renderer)
    end
end

function Level_Abstract:addEnemy(enemy)
    assert(enemy.is_a(Character_Enemy_Default), 'Must be an instance of Character_Enemy_Default')
    table.insert(self.enemies, enemy)
end

function Level_Abstract:getEnemies()
    return self.enemies
end

function Level_Abstract:addPlayer(player)
    assert(player.is_a(Character_Player_Default), 'Must be an instance of Character_Player_Default')

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
