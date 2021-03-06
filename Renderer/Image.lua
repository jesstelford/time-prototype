Renderer_Image = {} -- avoid circular dependancies
Renderer_Abstract = Renderer_Abstract or require "Renderer.Abstract"

--- Renderable class implementing Visitor Pattern
Renderer_Image = Class {
    inherits = Renderer_Abstract
}

function Renderer_Image:renderRenderable_Image(renderable)
    local position = renderable:getRenderPosition()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(renderable:getImage(), position.x, position.y)
end

function Renderer_Image:renderCharacter_Player_Default(character)
    self:renderRenderable_Image(character)
end

function Renderer_Image:renderCharacter_Enemy_Default(character)
    self:renderRenderable_Image(character)
end

function Renderer_Image:renderScenery_Wall(scenery)
    self:renderRenderable_Image(scenery)
end

return Renderer_Image
