local Node = {

    init = function (self)
        self.rootNode = abyss.getRootNode()
        abyss.log("info", "Hello from " .. self.__class .. " init")
    end,
}

function Node:new()
    local this = {}
    setmetatable(this, self)
    self:init()
    --abyss.log("info", "Hello from"..this.__class.." new")
    return this
end

return Node