local widget = require "widget"
local display = require "display"

local PackageView = {}
    
-- options
--[[
    Number x
    Number y
    Number width
    Number height
    Table  product
--]]
function PackageView.new(options)
    
    packageView = display.newContainer(options.width, options.height)
    packageView.anchorChildren = false
    packageView.delegate = options.delegate
    
    -- Backgorund Image
    local bgImage = display.newImageRect("Assets/Tariff.png", 290, 120)
    packageView:insert(bgImage)
    
    -- Header Text
    local indexLabel = display.newText(packageView, "ENDEKSLİ 1", 30, 10, 290, 80, native.systemFontBold, 20)

    packageView:translate(options.x, options.y)
    
    -- Button - Only functionalty, no visual elements
    local detailButton = widget.newButton{
        left    = 102,
        top     = 80,
        width   = 97,
        height  = 23,
        label   = "",
        labelAlign = "left",
        labelColor = { default={ 1, 0, 0 }, over={ 1, 0, 0, 0.5 } },
        emboss = true,
        onEvent   = function (event)
                        if event.phase == "began" then
                            --print "began"
                        elseif event.phase == "moved" then
                            --print "moved"
                        elseif event.phase == "ended" then
                            packageView.delegate:didPackageSelect(packageView)
                        end
                    end, 
    }
    
    packageView:insert(detailButton)
    
    return packageView
end

return PackageView
