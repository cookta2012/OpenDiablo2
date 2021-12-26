ButtonTypes = {
    Tall = {
        Font                = SystemFonts.FntExocet10,
        Image               = imgButtonTallBlank,
        Segments            = { X =   1, Y =   1 },
        FixedSize           = { X = 168, Y =  60 },
        TextOffset          = { X =   0, Y =  -5 },
        TextVerticalSpacing = 4,
        TextColor           = TextColor.White,
        LabelBlend          = "multiply",
        Uppercase           = true,
        FrameIndexes        = { ["normal"] = 0, ["pressed"] = 1 }
    },
    Wide = {
        Font                = SystemFonts.FntExocet10,
        Image               = imgButtonWideBlank,
        Segments            = { X =   2, Y =   1 },
        FixedSize           = { X = 272, Y =  35 },
        TextOffset          = { X =   0, Y =  -3 },
        TextColor           = TextColor.White,
        LabelBlend          = "multiply",
        Uppercase           = true,
        FrameIndexes        = { ["normal"] = 0, ["pressed"] = 2 }
    },
    Medium = {
        Font                = SystemFonts.FntExocet10,
        Image               = imgButtonMediumBlank,
        Segments            = { X =   1, Y =   1 },
        FixedSize           = { X = 128, Y =  35 },
        TextOffset          = { X =   0, Y =  -2 },
        TextColor           = TextColor.White,
        LabelBlend          = "multiply",
        Uppercase           = true,
        FrameIndexes        = { ["normal"] = 0, ["pressed"] = 1 }
    },
    Short = {
        Font                = SystemFonts.FntRidiculous,
        Image               = imgButtonShortBlank,
        Segments            = { X =   1, Y =   1 },
        FixedSize           = { X = 135, Y =  25 },
        TextOffset          = { X =   0, Y =  -5 },
        TextColor           = TextColor.White,
        LabelBlend          = "multiply",
        Uppercase           = true,
        FrameIndexes        = { ["normal"] = 0, ["pressed"] = 1 }
    },
    Checkbox = {
        Font                = SystemFonts.FntFormal12,
        Image               = imgCheckbox,
        Segments            = { X =   1, Y =   1 },
        FixedSize           = { X = 135, Y =  25 },
        TextOffset          = { X =  20, Y =  -5 },
        TextColor           = TextColor.White,
        LabelBlend          = "none",
        Uppercase           = false,
        FrameIndexes        = { normal = 0, hover = 3, pressed = 1, checkednormal = 4, checkedhover = 6, checkedpressed = 5, disabled = 2 }
    }
}