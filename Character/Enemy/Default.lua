Character_Enemy_Default = Class {

    inherits = Character_Abstract,
    name = 'Character_Enemy_Default',

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        Character_Abstract.construct(self, image)
    end
}

-- Required variable from Abstract class
Character_Enemy_Default.pos = {x=10,y=10}
