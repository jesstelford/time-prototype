--- Renderable class implementing Visitor Pattern
Renderer_Collision = Class {
    inherits = Renderer_Abstract
}

function Renderer_Collision:renderRenderable_Image(collidable)
    local colSize = collidable:getCollisionSize()
    local colPos = collidable:getPosition()
    love.graphics.rectangle('line', colPos.x - (colSize.x / 2), colPos.y - (colSize.y / 2), colSize.x, colSize.y)
end

function Renderer_Collision:renderCharacter_Player_Default(character)
    self:renderRenderable_Image(character)
end

function Renderer_Collision:renderCharacter_Enemy_Default(character)
    self:renderRenderable_Image(character)
end

function Renderer_Collision:renderScenery_Wall(scenery)
    self:renderRenderable_Image(scenery)
end
