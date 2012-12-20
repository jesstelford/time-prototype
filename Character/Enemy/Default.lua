Character_Enemy_Default = {} -- avoid circular dependancies
Character_Abstract = Character_Abstract or require "Character.Abstract"
Collidable_Box = Collidable_Box or require "Collidable.Box"

Character_Enemy_Default = Class {

    inherits = {Character_Abstract, Collidable_Box},
    name = 'Character_Enemy_Default',

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        Character_Abstract.construct(self, image, image:getWidth() / 2, image:getHeight() / 2)
        Collidable_Box.construct(self, xPosition, yPosition, image:getWidth(), image:getHeight())
    end
}

return Character_Enemy_Default
