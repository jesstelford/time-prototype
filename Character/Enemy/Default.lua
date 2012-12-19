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
