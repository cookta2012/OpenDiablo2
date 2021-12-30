

local UI = {}

function UI:init()
    if self.rootNode == nil then self.rootNode = abyss.getRootNode() end
    return self
end

function UI:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index=self
    --this:init()
    --abyss.log("info", "Hello from"..this.__class.." new")
    return o
end

function UI:newSprite(name, sprite, palette, cellsize, active)
    -- Main Background
    self.data[name] = CreateUniqueSpriteFromFile(sprite, palette)
    self.data[name]:setCellSize(cellsize[0], cellsize[0])
    if type(active) == "boolean" then self.data[name].active = active end
    return self.data[name]
end

return UI
