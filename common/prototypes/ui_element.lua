local Element = {
    __class = "Element",
    __index = require("common/prototypes/node"),

}


-- Creates a button
-- @buttonType The type of button to create
-- @param x The x position of the button
-- @param y The y position of the button
-- @param text The text to display on the button
function CreateButton(buttonSpec, x, y, text, onActivate)
    local label = abyss.createLabel(buttonSpec.Font)
    label:setAlignment("middle", "middle")
    label:setPosition(math.floor(buttonSpec.FixedSize.X / 2) + buttonSpec.TextOffset.X, math.floor(buttonSpec.FixedSize.Y / 2) + buttonSpec.TextOffset.Y)
    label:setColorMod(buttonSpec.TextColor.R, buttonSpec.TextColor.G, buttonSpec.TextColor.B)
    if buttonSpec.TextVerticalSpacing ~= nil then label.verticalSpacing = buttonSpec.TextVerticalSpacing end
    local result = abyss.createButton(buttonSpec.Image)
    result.data.label = label
    result:appendChild(label)
    result:setSegments(buttonSpec.Segments.X, buttonSpec.Segments.Y)
    result:setFixedSize(buttonSpec.FixedSize.X, buttonSpec.FixedSize.Y)
    if buttonSpec.Uppercase then
        label.caption = text:upper()
    else
        label.caption = text
    end
    label.blendMode = buttonSpec.LabelBlend
    result:setPosition(x, y)
    result:setPressedOffset(-2, 2)
    result:onActivate(onActivate)
    result:onPressed(function()
        ButtonPressedSfx:play()
    end)
    result:onMouseEnter(function()
        IsOnButton=true
    end)
    result:onMouseLeave(function()
        IsOnButton=false
    end)

    for k, v in pairs(buttonSpec.FrameIndexes) do
        result:setFrameIndex(k, v)
    end

    return result
end

function CreateCheckbox(x, y, text)
    local btn
    btn = CreateButton(ButtonTypes.Checkbox, x, y, text, function()
        btn.checked = not btn.checked
    end)

    return btn
end

function CreateUniqueSpriteFromFile(file, palette)
    local img = abyss.loadImage(file, palette)
    local spr = abyss.createSprite(img)
    spr.data.img = img
    return spr
end

--Element.__index = Element.prototype
return Element