--- Renderable class implementing Visitor Pattern
Renderer_Image = Class {
    inherits = Renderer_Abstract
}

function Renderer_Image:renderCharacter_Player_Default(character)
    local position = character:getRenderPosition()
    love.graphics.draw(character:getImage(), position.x, position.y)
end

function Renderer_Image:renderCharacter_Enemy_Default(character)
    self:renderCharacter_Player_Default(character)
end
