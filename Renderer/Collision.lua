--- Renderable class implementing Visitor Pattern
Renderer_Collision = Class {
    inherits = Renderer_Abstract
}

function Renderer_Collision:renderCharacter_Player_Default(character)
    local colSize = character:getCollisionSize()
    local colPos = character:getPosition()
    love.graphics.rectangle('line', colPos.x - (colSize.x / 2), colPos.y - (colSize.y / 2), colSize.x, colSize.y)
end

function Renderer_Collision:renderCharacter_Enemy_Default(character)
    local colSize = character:getCollisionSize()
    local colPos = character:getPosition()
    love.graphics.rectangle('line', colPos.x - (colSize.x / 2), colPos.y - (colSize.y / 2), colSize.x, colSize.y)
end
