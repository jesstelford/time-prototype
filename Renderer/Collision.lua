Renderer_Collision = {} -- avoid circular dependancies
Renderer_Abstract = Renderer_Abstract or require "Renderer.Abstract"

--- Renderable class implementing Visitor Pattern
Renderer_Collision = Class {
    inherits = Renderer_Abstract
}

function Renderer_Collision:renderRenderable_Image(collidable)

    local colHalfSize = collidable:getCollisionSize() / 2
    local colPos = collidable:getPosition()

    if collidable:isColliding() then

        love.graphics.setColor(255, 255, 0)
        for _, normal in pairs(collidable:getCollisionNormals()) do
            normal = normal * 10
            love.graphics.line(colPos.x, colPos.y, colPos.x + normal.x, colPos.y + normal.y)
        end

        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
    end

    love.graphics.rectangle('line', colPos.x - colHalfSize.x, colPos.y - colHalfSize.y, colHalfSize.x * 2, colHalfSize.y * 2)
end

function Renderer_Collision:renderCharacter_Player_Default(character)

    local collisionX, collisionY = character:center()

    if character:isColliding() then

        love.graphics.setColor(255, 255, 0)
        for _, normal in pairs(character:getCollisionNormals()) do
            love.graphics.line(collisionX, collisionY, collisionX + normal.x, collisionY + normal.y)
        end

        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
    end

    character:draw()
end

function Renderer_Collision:renderCharacter_Enemy_Default(character)
    self:renderRenderable_Image(character)
end

function Renderer_Collision:renderScenery_Wall(scenery)
    self:renderCharacter_Player_Default(scenery)
end

return Renderer_Collision
