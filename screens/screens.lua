local rootNode = abyss.getRootNode()

ScreenType = {
    MAIN_MENU = 1,
    CREDITS = 2,
    MAP_ENGINE_TEST = 3,
    CHARACTER_SELECTION = 4
}

Screens = {
    [ScreenType.MAIN_MENU] = require("screens/main-menu"),
    [ScreenType.CREDITS] = require("screens/credits"),
    [ScreenType.MAP_ENGINE_TEST] = require("screens/map-engine-test"),
    [ScreenType.CHARACTER_SELECTION] = require("screens/character-selection"),
}

function SetScreen(screenType)
    abyss.getRootNode():removeAllChildren()
    abyss.resetMouseState()
    IsOnButton=false
    abyss.log("info",dump(Screens[screenType]))
    CurrentScreen = Screens[screenType]:new()
end
