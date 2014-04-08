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
    
    -- Properties
    local width      = options.width
    local height     = options.height
    local product    = options.product
    local delegate   = options.delegate
    
    -- Widget Properties
    local bgImage
    local indexLabel
    local iconImage
    local detailButton
    
    -- New PackageView
    local packageView = display.newGroup()
    packageView.product = product
    
    -- Backgorund Image
    bgImage = display.newImageRect("Assets/Tariff.png", width, height)
    packageView:insert(bgImage)

    -- Header Text
    indexLabel = display.newText(packageView, product.name, 90, 14, 290, 80, native.systemFontBold, 20)
    
    -- Check Icon
    iconImage  = display.newImage(packageView, "Assets/IconSelectTariffPressed.png", system.ResourceDirectory, -12, -9, true)
    iconImage.isVisible = false
    
    packageView:translate(options.x, options.y)
    
    -- Button - Only functionalty, no visual elements
    detailButton = widget.newButton{
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
                            delegate:didPackageSelect(packageView)
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
