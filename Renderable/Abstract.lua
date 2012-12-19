--- Renderable class implementing Visitor Pattern
Renderable_Abstract = Class {}

function Renderable_Abstract:renderTo(renderer)
    -- must be of type Collidable_Abstract to collide with
    assert(renderer:is_a(Renderer_Abstract), 'Can only render to a renderer')

    selfType = tostring(getmetatable(self))

    funcName = 'render' .. selfType

    if type(renderer[funcName]) == 'function' then
        return renderer[funcName](renderer, self)
    else
        return renderer:default(self)
    end

end
