local widget  = require "widget"
local display = require "display"

-- PackageView Factory Module
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
    
    -- New PackageView
    local packageView = display.newGroup()
    packageView.delegate = options.delegate
    
    -- Backgorund Image
    local bgImage = display.newImageRect("Assets/Tariff.png", 290, 120)
    packageView:insert(bgImage)
    
    -- Header Text
    local indexLabel = display.newText(packageView, "ENDEKSLİ 1", 90, 14, 290, 80, native.systemFontBold, 20)
    
    -- Check Icon
    local iconImage  = display.newImage(packageView, "Assets/IconSelectTariffPressed.png", system.ResourceDirectory, -12, -9, true)
    iconImage.isVisible = false
    
    packageView:translate(options.x, options.y)
    
    -- Button - Only functionalty, no visual elements
    local detailButton = widget.newButton{
        left    = 102,
        top     = 80,
        width   = 97,
        height  = 23,
        label   = "",
        labelAlign = "left",
        labelColor = { default={ 1, 0, 0, }, over={ 1, 0, 0, 0.5 } },
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
    detailButton.isVisible = true
    
    packageView:insert(detailButton)
    
    -- METHODS
    function packageView:getIcon()
        return iconImage
    end
    
    return packageView
end

return PackageView
