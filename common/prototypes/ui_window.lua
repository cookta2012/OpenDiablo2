
local Window = {
    __class = "Window",
    __index = require("common/prototypes/ui_element"),

    init = function(self)
        abyss.log("info", "Hello from "..self.__class.." init")
        self.prototype:init()
        self.elements = {}
    end,
    
    addElement = function(self, name,type,data)
        abyss.log("info", dump(self))
        table.insert(self.elements,"info")
    end,
    
    getChildren = function (self)
        return self.elements
    end
}
--Window.__index = Window.prototype



return Window