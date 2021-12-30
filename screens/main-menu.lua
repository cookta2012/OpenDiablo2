
--<Erutuon> i.e., this works: local obj = setmetatable({}, { __index = { new = function() end } }); obj:new();
--<Erutuon> this doesn't: local obj = {__index = { new = function() end } }; obj:new();
--<cookta2012> I thought I was doing that if you look at the Node prototype
--<cookta2012> common/prototype/node
--<cookta2012> Can I not set metatable that way?
--<cookta2012> So are you saying that the setmetable call must be within the actual class?
--<cookta2012> And that can't be called off of a super class
--<Erutuon> trying to understand because I haven't set up very complex object hierarchies in Lua...
--<cookta2012> Some people would say what I'm doing is stupid but. It's what I got to work with
--<Erutuon> common/prototypes.node looks like it's not setting the metatable right
--<Erutuon> actually, it's setting the metatable on the right thing, `this`
--<Erutuon> but it should have `this:init()` rather than `self:init()`
--<Erutuon> and the metatable should have an `__index.init = function(self) ... end` field in it
--<Erutuon> define `metatable.__index.init`, so that when you do `setmetatable(obj, metatable)` you can call `obj:init()` and it'll find the method you defined
--<Erutuon> at the moment you have `metatable.init` defined
--<Erutuon> where metatable is Node

--local UI = require("common/prototypes/ui")
local MainMenu = {}
local uiRoot

function MainMenu:new()
    if abyss.fileExists("/data/hd/global/music/introedit_hd.flac") then
        abyss.playBackgroundMusic("/data/hd/global/music/introedit_hd.flac")
    else
        abyss.playBackgroundMusic(ResourceDefs.BGMTitle)
    end
    --uiRoot = UI.new()
    --abyss.log("info",dump(uiRoot:new()))
end

--[[
function MainMenu:init()
    if abyss.fileExists("/data/hd/global/music/introedit_hd.flac") then
        abyss.playBackgroundMusic("/data/hd/global/music/introedit_hd.flac")
    else
        abyss.playBackgroundMusic(ResourceDefs.BGMTitle)
    end
    self.elements.rootNode = abyss.getRootNode()
    self:addElement("test","tes1")
    self:getChildren()

    -- OpenDiablo Version Label
    elements.lblVersion = abyss.createLabel(SystemFonts.FntFormal12)
    elements.lblVersion:setPosition(790, 0)
    elements.lblVersion.caption = "OpenDiablo II v0.01"
    elements.lblVersion:setAlignment("end", "middle")

    -- Disclaimer Label
    elements.lblDisclaimer = abyss.createLabel(SystemFonts.FntFormal10)
    elements.lblDisclaimer.caption = "OpenDiablo II is neither developed by, nor endorsed by Blizzard or its parent company Activision"
    elements.lblDisclaimer:setPosition(400, 580)
    elements.lblDisclaimer:setAlignment("middle", "start")
    elements.lblDisclaimer:setColorMod(0xFF, 0xFF, 0x8C)

    -- Trademark Screen
    elements.trademarkBg = CreateUniqueSpriteFromFile(ResourceDefs.TrademarkScreen, ResourceDefs.Palette.Sky)
    elements.trademarkBg:setCellSize(4, 3)
    elements.trademarkBg:onMouseButtonDown(function(buttons)
        abyss.resetMouseState();
        elements.trademarkBg.active = false
        elements.mainBg.active = true
        self = nil
    end)

    -- Main Background
    elements.mainBg = CreateUniqueSpriteFromFile(ResourceDefs.GameSelectScreen, ResourceDefs.Palette.Sky)
    elements.mainBg:setCellSize(4, 3)
    elements.mainBg.active = false

    -- D2 Logo Left Black BG
    elements.d2LogoLeftBlackBg = CreateUniqueSpriteFromFile(ResourceDefs.Diablo2LogoBlackLeft, ResourceDefs.Palette.Sky)
    elements.d2LogoLeftBlackBg:setPosition(400, 120)
    elements.d2LogoLeftBlackBg.bottomOrigin = true
    elements.d2LogoLeftBlackBg.playMode = "forwards"

    -- D2 Logo Right Black BG
    elements.d2LogoRightBlackBg = CreateUniqueSpriteFromFile(ResourceDefs.Diablo2LogoBlackRight, ResourceDefs.Palette.Sky)
    elements.d2LogoRightBlackBg:setPosition(400, 120)
    elements.d2LogoRightBlackBg.bottomOrigin = true
    elements.d2LogoRightBlackBg.playMode = "forwards"

    -- D2 Logo Left
    elements.d2LogoLeft = CreateUniqueSpriteFromFile(ResourceDefs.Diablo2LogoFireLeft, ResourceDefs.Palette.Sky)
    elements.d2LogoLeft:setPosition(400, 120)
    elements.d2LogoLeft.blendMode = "additive"
    elements.d2LogoLeft.bottomOrigin = true
    elements.d2LogoLeft.playMode = "forwards"

    -- D2 Logo Right
    elements.d2LogoRight = CreateUniqueSpriteFromFile(ResourceDefs.Diablo2LogoFireRight, ResourceDefs.Palette.Sky)
    elements.d2LogoRight:setPosition(400, 120)
    elements.d2LogoRight.blendMode = "additive"
    elements.d2LogoRight.bottomOrigin = true
    elements.d2LogoRight.playMode = "forwards"

    -- Cinematics Window
    elements.cinematicsDialog = self:createCinematicsWindow()

    -- Menu Buttons
    elements.btnSinglePlayer = CreateButton(ButtonTypes.Wide, 264, 290, "Single Player", function()
        SetScreen(ScreenType.CHARACTER_SELECTION)
        -- TODO
    end)

    elements.btnLocalNetplay = CreateButton(ButtonTypes.Wide, 264, 330, "Local NetPlay", function()
        local function output(node, offset)
            local x, y = node:getPosition()
            local line = node:nodeType() .. " X=" .. dump(x) .. " Y="..dump(y)
            if node.data.layout ~= nil then
                line = line .. " Layout type=" .. node.data.layout.type .. " name=" .. or_else(node.data.layout.name, "(nil)")
            end
            local label = node:castToLabel()
            if label ~= nil then
                line = line .. " text: " .. label.caption
            end
            for i = 1, offset do
                line = "    " .. line
            end
            abyss.log("info", line)
            local children = node:getChildren()
            for _, child in ipairs(children) do
                output(child, offset+1)
            end
        end
        output(elements.rootNode, 0)
        -- TODO
    end)

    elements.btnMapEngineDebug = CreateButton(ButtonTypes.Wide, 264, 400, "Map Engine Test", function()
        SetScreen(ScreenType.MAP_ENGINE_TEST)
    end)

    elements.btnCredits = CreateButton(ButtonTypes.Short, 264, 472, "Credits", function()
        SetScreen(ScreenType.CREDITS)
    end)

    elements.btnCinematics = CreateButton(ButtonTypes.Short, 401, 472, "Cinematics", function()
        elements.cinematicsDialog.show()
        elements.btnSinglePlayer.active = false
        elements.btnLocalNetplay.active = false
        elements.btnExitGame.active = false
        elements.btnCredits.active = false
        elements.btnCinematics.active = false
        elements.btnMapEngineDebug.active = false
    end)

    elements.btnExitGame = CreateButton(ButtonTypes.Wide, 264, 500, "Exit to Desktop", function()
        abyss.shutdown()
    end)

    -- Append all nodes to the scene graph
    elements.mainBg:appendChild(elements.lblVersion)
    elements.mainBg:appendChild(elements.lblDisclaimer)
    elements.mainBg:appendChild(elements.btnSinglePlayer)
    elements.mainBg:appendChild(elements.btnLocalNetplay)
    elements.mainBg:appendChild(elements.btnExitGame)
    elements.mainBg:appendChild(elements.btnCredits)
    elements.mainBg:appendChild(elements.btnCinematics)
    elements.mainBg:appendChild(elements.btnMapEngineDebug)
    elements.rootNode:appendChild(elements.trademarkBg)
    elements.rootNode:appendChild(elements.mainBg)
    elements.rootNode:appendChild(elements.d2LogoLeftBlackBg)
    elements.rootNode:appendChild(elements.d2LogoRightBlackBg)
    elements.rootNode:appendChild(elements.d2LogoLeft)
    elements.rootNode:appendChild(elements.d2LogoRight)

    elements.rootNode:appendChild(elements.cinematicsDialog.window)

    --local testLayout = LayoutLoader:load('HUDPanel.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('PlayerInventoryExpansionLayout.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('PlayerInventoryOriginalLayout.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('CharacterStatsPanel.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('CharacterCreatePanel.json', ResourceDefs.Palette.Fechar)
    --local testLayout = LayoutLoader:load('QuestLogPanelOriginal.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('QuestLogPanelExpansion.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('HirelingInventoryPanel.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('WaypointsPanelOriginal.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('WaypointsPanelExpansion.json', ResourceDefs.Palette.Sky)
    --local testLayout = LayoutLoader:load('VendorPanelLayout.json', ResourceDefs.Palette.Sky)
    --elements.testLayout = testLayout
    --if testLayout then
    --    elements.rootNode:appendChild(testLayout)
    --end

    if ShowTrademarkScreen == false then
        elements.trademarkBg.active = false
        elements.mainBg.active = true
    else
        ShowTrademarkScreen = false
    end
end

function MainMenu:createCinematicsWindow()
    local result = {
        window = CreateUniqueSpriteFromFile(ResourceDefs.CinematicsBackground, ResourceDefs.Palette.Sky),
        main = self,
        buttons = {}
    }

    result.window:setCellSize(2, 2)
    result.window:setPosition(237, 80)

    local showHD = false
    if abyss.fileExists("/data/hd/global/video/d2intro.webm") then
        showHD = true
    end

    result.lblHeader = abyss.createLabel(SystemFonts.Fnt30)
    result.lblHeader.caption = "Select Cinematics"
    result.lblHeader:setPosition(163, cond(showHD, 10, 20))
    result.lblHeader:setAlignment("middle", "start")

    local files = {{
        name = "THE SISTER'S LAMENT",
        bik = "d2intro640x292.bik",
        hd = "d2intro",
    }, {
        name = "DESERT JOURNEY",
        bik = "Act02start640x292.bik",
        hd = "act2/act02start",
    }, {
        name = "MEPHISTO'S JUNGLE",
        bik = "Act03start640x292.bik",
        hd = "act3/act03start",
    }, {
        name = "ENTER HELL",
        bik = "Act04start640x292.bik",
        hd = "act4/act04start",
    }, {
        name = "TERROR'S END",
        bik = "Act04end640x292.bik",
        hd = "act4/act04end",
    }, {
        name = "SEARCH FOR BAAL",
        bik = "D2x_Intro_640x292.bik",
        hd = "d2x_intro",
    }, {
        name = "DESTRUCTION'S END",
        bik = "D2x_Out_640x292.bik",
        hd = "act5/d2x_out",
    }}

    local y = cond(showHD, 50, 70)

    for _, item in ipairs(files) do
        local btn = CreateButton(ButtonTypes.Wide, 30, y, item.name, function()
            if result.btnToggleHD.checked then
                abyss.playVideoAndAudio("/data/hd/global/video/" .. item.hd .. ".webm", Language:hdaudioPath("/data/hd/local/video/" .. item.hd .. ".flac"))
            else
                if abyss.fileExists("/data/global/video/" .. item.hd .. ".webm") then
                    abyss.playVideoAndAudio("/data/global/video/" .. item.hd .. ".webm", Language:hdaudioPath("/data/local/video/" .. item.hd .. ".flac"))
                else
                    abyss.playVideo("/data/local/video/" .. Language:code() .. "/" .. item.bik)
                end
            end
        end)

        table.insert(result.buttons, btn)
        result.window:appendChild(btn)

        y = y + 40
    end

    result.btnToggleHD = CreateCheckbox(97, 333, "HD video")
    if showHD then
        result.btnToggleHD.checked = true
        result.window:appendChild(result.btnToggleHD)
    end

    result.btnCancel = CreateButton(ButtonTypes.Medium, 100, 375, "CANCEL", function()
        result.main.btnSinglePlayer.active = true
        result.main.btnLocalNetplay.active = true
        result.main.btnExitGame.active = true
        result.main.btnCredits.active = true
        result.main.btnCinematics.active = true
        result.main.btnMapEngineDebug.active = true
        result:hide()
    end)

    result.window:appendChild(result.lblHeader)
    result.window:appendChild(result.btnCancel)
    result.window.active = false

    result.show = function()
        abyss.playBackgroundMusic("")
        result.window.active = true
    end

    result.hide = function()
        if abyss.fileExists("/data/hd/global/music/introedit_hd.flac") then
            abyss.playBackgroundMusic("/data/hd/global/music/introedit_hd.flac")
        else
            abyss.playBackgroundMusic(ResourceDefs.BGMTitle)
        end
        result.window.active = false
    end

    return result

end
]]--
return MainMenu
