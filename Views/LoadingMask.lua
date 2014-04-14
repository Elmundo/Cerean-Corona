local widget = require "widget"
local display = require "display"
local graphics = require "graphics"

-- Loading Mask Module
local LoadingMask = {}

function LoadingMask.new( options )
    
    local loadingMask = {}
    
    -- Properties
    local group = options.view
    local imageSheet = nil
    local spinner = nil
    local mask = nil
    
    mask = display.newRect(0, 0, 1280, 1280)
    mask:setFillColor(0, 0, 0, 0.5)
    mask.isVisible = false
    mask:addEventListener("touch", function() return true end)
    mask:addEventListener("tap", function() return true end)

    imageSheet = graphics.newImageSheet("Assets/spinner.png",system.ResourceDirectory , {
        frames = {
            {
                x=0,
                y=0,
                width=64,
                height=64,
            }
        },
        
        sheetContentWidth = 64,
        sheetContentHeight = 64,
    })
    
    spinner = widget.newSpinner {
        width = 64,
        height = 64,
        sheet = imageSheet,
        startFrame = 1,
        deltaAngle = 30,
        incrementEvery = 40,
    }
    
    local centerX = display.contentCenterX
    local centerY = display.contentCenterY
    spinner.x = centerX
    spinner.y = centerY
    spinner.isVisible = false
    
    function loadingMask:start()
        group:insert(group.numChildren+1, mask)
        group:insert(group.numChildren+1, spinner)
        spinner:start()
        mask.isVisible = true
        spinner.isVisible = true
    end
    
    function loadingMask:stop()
        group:remove(mask)
        group:remove(spinner)
        spinner:stop()
        mask.isVisible = false
        spinner.isVisible = false
    end
    
    return loadingMask
end

return LoadingMask
