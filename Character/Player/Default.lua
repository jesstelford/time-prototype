-- Declare a new class called Level_1
Character_Player_Default = Class {

    inherits = Character_Abstract,

    --- Constructor
    -- @param self A reference to the object being constructed
    -- @param image (Image) The image to render
    function(self, image)
        Character_Abstract.construct(self, image)
    end
}

-- Required variable from Abstract class
Character_Player_Default.pos = {x=300,y=300}
