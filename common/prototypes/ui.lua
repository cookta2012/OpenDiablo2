
local UI = {
    __class = "UI",
    __index = require("common/prototypes/ui_window"),
    
    getChildren = function (self)
        return self.getChildren(self)
    end
}
--UI.__index = UI.prototype
local Background

return UI